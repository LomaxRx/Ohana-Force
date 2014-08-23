global class Ohana {

    private String url = 'http://ohanapi.herokuapp.com:80/api/';
    private String ApiKey;

    public Organization Organizations;
    public Program Programs;
    public Service Services;

    public Ohana( String key ){

        if( key != '' ){
            ApiKey = key;
        }

        // thinking about adding some classes to easily
        // GET/PUT on a given collection like
        // Ohana.Organizations.insert( 'foo', 'bar' ); 
        Organizations = new Organization( this );
        Programs      = new Program( this );
        Services      = new Service( this );
    }

    // using a map with list    
    public String find( Map<String, Object> m ){
        String qry = getQry( m );
        return query( qry );
    }

    public String find_by_id( String collection, String id ){
        String qry = url + collection + '/' + id;
        return query( qry );
    }

    public class Organization {
       
        public Ohana o;
        
        public Organization( Ohana oh ){
            o = oh;
        }

        public String find( String name ){
            String qry = o.url + 'search?org_name=' + name;
            return o.query( qry );
        }

        public String find_by_id( String id ){
            String qry = o.url + 'organizations/' + id + '/locations';
            return o.query( qry );
        }

    }

    public class Service {
        
        public Ohana o;
        
        public Service( Ohana oh ){
            o = oh;
        }
        
        public String find( List<String> serves ){
            String qry = o.url + 'search?' ;
            for ( String s : serves ){
                qry += 'service[]=' + s + '&';
            }

            return o.query( qry );
        }

        public String find_by_id( String id ){
            String qry = o.url + 'service/' + id;
            return o.query( qry );
        }

    }

    public class Program {
        public Ohana o;
        
        public Program( Ohana oh ){
            o = oh;
        }
        public String find( List<String> progs ){
            String qry = o.url + 'search?';
            for ( String p : progs ){
                qry += 'program[]=' + p + '&';
            }
            return o.query( qry );

        }

        public String find_by_id( String id ){
            String qry = o.url + 'program/' + id;
            return o.query( qry );
        }

    }

    private String getQry( Map<String, Object > m ){
       String qry = url + 'search?' ;
        for( String k : m.keySet() ){
          
            Boolean isArray = m.get( k ) instanceof List<String>;
           
           if( isArray ){
                List<String> val = (List<String>)m.get( k );
                for( String v : val ){
                    qry += k + '[]=' + v;
                }
            } else {
                qry += k + '=' + m.get( k );
            }   
        }

        return qry;
    }

    private String query( String uri ){
      
        Http rest = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint( uri );
        req.setMethod( 'GET' );
        req.setHeader('User-Agent', 'Bread for the City');
        req.setHeader('Accept', 'application/json');
        if( ApiKey != null ){
            req.setHeader( 'X-Api-Token', ApiKey );
        }
        HttpResponse res = rest.send( req );
        String response = res.getBody();
        system.debug( response );
        return response;

    }

}