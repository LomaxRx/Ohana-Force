public class OhanaController{

    private Ohana o;

    public String searchterm {get; set;}
    public List<Object> results {get; set;}

    public OhanaController(){
        o = new Ohana( '' );
    }

    public void search(){
        Map<String, Object> terms = new Map<String, Object>();
   
        terms.put( 'keyword', searchterm );

        String response = o.find( terms );
        results = (List<Object>)JSON.deserializeUntyped( response );

    }

    public void organization(){
        String id = ApexPages.currentPage().getParameters().get('id');
        String response = o.Organizations.find_by_id( id );
        results = (List<Object>)JSON.deserializeUntyped( response );
    }


}