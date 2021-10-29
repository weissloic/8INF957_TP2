package uqac.aop.chess;

public aspect test {

    pointcut greeting() : execution(public void play(..));

    void around(): greeting() {
        //System.out.println(thisJoinPoint.getSignature().getName());
        System.out.println("fefesfs");
        proceed();
        //System.out.println(thisJoinPoint.getSignature().getName());
    }
}