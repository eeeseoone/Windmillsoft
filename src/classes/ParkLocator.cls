public class ParkLocator {
    public static String[] country(String ctry) {
        ParkService.ParksImplPort prk = 
            new ParkService.ParksImplPort();
        return prk.byCountry(ctry);
    }
}