public class WrapperBean {
    public List<Bean> listBean;
    public long count;
    
    public WrapperBean(List<Bean> listBean) {
       this.count = listBean.size();
       this.listBean = listBean;
    }
} 