import React, { createContext, useContext, useReducer, ReactNode } from 'react';

/* ── State Types ── */
export type Stage =
    | 'intro'
    | 'kivilcim_answered'
    | 'meridyen_mapped'
    | 'main_intervention'
    | 'why_pending'
    | 'feynman_pending'
    | 'transfer_done'
    | 'decision_ready';

export interface PusulaState {
    stage: Stage;
    kivilcimText: string;
    meridyenIntent: string | null;
    meridyenVariables: { label: string; variable: string; op: string }[];
    warmupCompleted: boolean;
    whyText: string;
    feynmanText: string;
    transferScores: number[];
    rubricScores: {
        problemTanimlama: number;
        veriAnalizi: number;
        yaraticiCozum: number;
        iletisim: number;
        transfer: number;
    };
    codelabValues: {
        acikGise: number;
        islemSuresi: number;
        oncelikliOran: number;
    };
    currentSection: number;
    yetkinlikPuani: number;
    kazanilanBeceriler: string[];
    showYetkinlikPopup: { amount: number; label: string } | null;
}

/* ── Actions ── */
type Action =
    | { type: 'SET_KIVILCIM'; text: string }
    | { type: 'COMPLETE_KIVILCIM' }
    | { type: 'COMPLETE_WARMUP' }
    | { type: 'SET_MERIDYEN'; intent: string; variables: { label: string; variable: string; op: string }[] }
    | { type: 'SET_CODELAB'; values: Partial<PusulaState['codelabValues']> }
    | { type: 'SET_WHY'; text: string }
    | { type: 'SET_FEYNMAN'; text: string }
    | { type: 'COMPLETE_GATES' }
    | { type: 'COMPLETE_TRANSFER'; scores: number[] }
    | { type: 'UPDATE_RUBRIC'; scores: Partial<PusulaState['rubricScores']> }
    | { type: 'SET_SECTION'; index: number }
    | { type: 'ADVANCE_STAGE'; stage: Stage }
    | { type: 'ADD_YETKINLIK'; amount: number; label: string; beceri?: string }
    | { type: 'HIDE_YETKINLIK_POPUP' };

/* ── Initial State ── */
const initialState: PusulaState = {
    stage: 'intro',
    kivilcimText: '',
    meridyenIntent: null,
    meridyenVariables: [],
    warmupCompleted: false,
    whyText: '',
    feynmanText: '',
    transferScores: [],
    rubricScores: {
        problemTanimlama: 0,
        veriAnalizi: 0,
        yaraticiCozum: 0,
        iletisim: 0,
        transfer: 0,
    },
    codelabValues: {
        acikGise: 3,
        islemSuresi: 8,
        oncelikliOran: 0.2,
    },
    currentSection: 0,
    yetkinlikPuani: 0,
    kazanilanBeceriler: [],
    showYetkinlikPopup: null,
};

/* ── Reducer ── */
function reducer(state: PusulaState, action: Action): PusulaState {
    switch (action.type) {
        case 'SET_KIVILCIM':
            return { ...state, kivilcimText: action.text };
        case 'COMPLETE_KIVILCIM':
            return { ...state, stage: 'kivilcim_answered' };
        case 'COMPLETE_WARMUP':
            return { ...state, warmupCompleted: true };
        case 'SET_MERIDYEN':
            return {
                ...state,
                stage: 'meridyen_mapped',
                meridyenIntent: action.intent,
                meridyenVariables: action.variables,
                rubricScores: {
                    ...state.rubricScores,
                    problemTanimlama: Math.min(100, state.rubricScores.problemTanimlama + 25),
                },
            };
        case 'SET_CODELAB':
            return {
                ...state,
                stage: 'main_intervention',
                codelabValues: { ...state.codelabValues, ...action.values },
                rubricScores: {
                    ...state.rubricScores,
                    veriAnalizi: Math.min(100, state.rubricScores.veriAnalizi + 15),
                    yaraticiCozum: Math.min(100, state.rubricScores.yaraticiCozum + 10),
                },
            };
        case 'SET_WHY':
            return {
                ...state,
                whyText: action.text,
                stage: 'why_pending',
                rubricScores: {
                    ...state.rubricScores,
                    iletisim: Math.min(100, state.rubricScores.iletisim + 30),
                },
            };
        case 'SET_FEYNMAN':
            return {
                ...state,
                feynmanText: action.text,
                stage: 'feynman_pending',
                rubricScores: {
                    ...state.rubricScores,
                    iletisim: Math.min(100, state.rubricScores.iletisim + 20),
                },
            };
        case 'COMPLETE_GATES':
            return { ...state, stage: 'transfer_done' };
        case 'COMPLETE_TRANSFER':
            return {
                ...state,
                stage: 'decision_ready',
                transferScores: action.scores,
                rubricScores: {
                    ...state.rubricScores,
                    transfer: Math.min(100, action.scores.reduce((a, b) => a + b, 0) / action.scores.length),
                },
            };
        case 'UPDATE_RUBRIC':
            return {
                ...state,
                rubricScores: { ...state.rubricScores, ...action.scores },
            };
        case 'SET_SECTION':
            return { ...state, currentSection: action.index };
        case 'ADVANCE_STAGE':
            return { ...state, stage: action.stage };
        case 'ADD_YETKINLIK':
            return {
                ...state,
                yetkinlikPuani: state.yetkinlikPuani + action.amount,
                kazanilanBeceriler: action.beceri && !state.kazanilanBeceriler.includes(action.beceri)
                    ? [...state.kazanilanBeceriler, action.beceri]
                    : state.kazanilanBeceriler,
                showYetkinlikPopup: { amount: action.amount, label: action.label },
            };
        case 'HIDE_YETKINLIK_POPUP':
            return { ...state, showYetkinlikPopup: null };
        default:
            return state;
    }
}

/* ── Context ── */
const PusulaContext = createContext<{
    state: PusulaState;
    dispatch: React.Dispatch<Action>;
} | null>(null);

export function PusulaProvider({ children }: { children: ReactNode }) {
    const [state, dispatch] = useReducer(reducer, initialState);
    return (
        <PusulaContext.Provider value={{ state, dispatch }}>
            {children}
        </PusulaContext.Provider>
    );
}

export function usePusula() {
    const ctx = useContext(PusulaContext);
    if (!ctx) throw new Error('usePusula must be used within PusulaProvider');
    return ctx;
}
