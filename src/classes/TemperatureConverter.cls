public class TemperatureConverter {
	//Takes a Fahrenheit temperature and returns the Celsius
    public static Decimal FahrenheigToCelsius(Decimal fh){
        Decimal cs = (fh - 32)*5/9;
        return cs.setScale(2);
    } 
}