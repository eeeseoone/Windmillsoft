public class Bean {
    public Id Id;
//    public String Name;
    public Bean(SObject sob) {
       this.Id = sob.Id;
//       this.Name = (String) sob.get('Name');
    }
} 