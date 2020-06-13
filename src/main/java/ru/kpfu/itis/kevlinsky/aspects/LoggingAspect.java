package ru.kpfu.itis.kevlinsky.aspects;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LoggingAspect {
    private Logger logger = LoggerFactory.getLogger(LoggingAspect.class);

    @AfterThrowing(pointcut = "within(ru.kpfu.itis.kevlinsky.*.*))", throwing = "exception")
    public void logAllExceptions(JoinPoint joinPoint, Throwable exception){
        logger.error("Method \"" + joinPoint.getSignature().getName() + "\" threw an exception: " + exception.getMessage());
    }
}
