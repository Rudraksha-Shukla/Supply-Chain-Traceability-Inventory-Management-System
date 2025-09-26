public class MyfirstClass {
    public static void method(Integer floor){
        if(floor>5){
            System.debug('Lift is going up');
        }
        else if(floor<5){
            System.debug('Lift is foing down');
        }
        else if(floor==5){
            System.debug('constant');
        }
    }
}