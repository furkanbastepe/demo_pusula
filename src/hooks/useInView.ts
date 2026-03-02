import { useEffect, useRef, useState } from 'react';

export function useInView(threshold = 0.2) {
    const ref = useRef<HTMLDivElement>(null);
    const [isVisible, setIsVisible] = useState(false);

    useEffect(() => {
        const el = ref.current;
        if (!el) return;

        const observer = new IntersectionObserver(
            ([entry]) => {
                if (entry.isIntersecting) {
                    setIsVisible(true);
                }
            },
            { threshold }
        );

        observer.observe(el);
        return () => observer.disconnect();
    }, [threshold]);

    return { ref, isVisible };
}

export function useAnimatedCounter(target: number, duration = 1200, trigger = true) {
    const [value, setValue] = useState(0);

    useEffect(() => {
        if (!trigger) return;
        let start = 0;
        const startTime = performance.now();

        function animate(now: number) {
            const elapsed = now - startTime;
            const progress = Math.min(elapsed / duration, 1);
            const eased = 1 - Math.pow(1 - progress, 3); // ease-out cubic
            setValue(Math.round(start + (target - start) * eased));
            if (progress < 1) requestAnimationFrame(animate);
        }

        requestAnimationFrame(animate);
    }, [target, duration, trigger]);

    return value;
}

export function useScrollProgress() {
    const [progress, setProgress] = useState(0);

    useEffect(() => {
        function onScroll() {
            const scrollTop = window.scrollY;
            const docHeight = document.documentElement.scrollHeight - window.innerHeight;
            setProgress(docHeight > 0 ? (scrollTop / docHeight) * 100 : 0);
        }
        window.addEventListener('scroll', onScroll, { passive: true });
        return () => window.removeEventListener('scroll', onScroll);
    }, []);

    return progress;
}
