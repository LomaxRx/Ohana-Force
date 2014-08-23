# Ohana-force

A simple [Ohana](http://ohanapi.org) wrapper for Salesforce, designed how I'd expect to interact with the API.

## Includes 

- Ohana API wrapper class 
- Example Ohana Controller 
- 2 Example Visualforce pages

## 

`Ohana o = new Ohana( '_apikey_' );`


Access general `/api/search?` by passing a key-value map to `o.find( _map_ )` or use
`o.find_by_id( _collection_ , _id_)`. You can map either a `String` or a `List<String>`.

## Example 

```java
Map<String, Object> m = new Map<String, Object>();

String term1 = 'food'
List<String> term2 = new List<String>();

term2.add( 'Human Services' );
term2.add( 'Food Pantry' );

m.put( 'keyword' , term1 );
m.put( 'kind' , term2 );

String response = o.find( m );
```

`.find...` returns a JSON string that you'll have to deserialize.


`List<Object> results = (List<Object>)JSON.deserialize( response );`


I've included some convenience classes that might be helpful when Ohana adds write access


`o.Organizations.find_by_id( '_id_' );`






