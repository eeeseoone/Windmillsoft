@isTest
public class TemperatureConverterTest {
    @isTest static void testWarmTemp(){
        Decimal celsius = TemperatureConverter.FahrenheigToCelsius(70);
        System.assertEquals(21.11, celsius);
    }
    @isTest static void testFreezingPoint(){
        Decimal celsius = TemperatureConverter.FahrenheigToCelsius(32);
        System.assertEquals(0, celsius);
    }
    @isTest static void testBoilingPoint(){
        Decimal celsius = TemperatureConverter.FahrenheigToCelsius(212);
        System.assertEquals(100, celsius, 'Boiling point temprature is not expected.');    
    }
    @isTest static void testNagativeTemp(){
        Decimal celsius = TemperatureConverter.FahrenheigToCelsius(-10);
        System.assertEquals(-23.33, celsius);
    }
}