import blprnt.nytimes.*; 

// per_facet (person) , org_facet (organization), geo_facet (geographic area)
// des_facet (description), publication_year, publication_month, page_facet
// http://developer.nytimes.com/docs/read/article_search_api

String apiKey = "0286F7A9A25EF5B036AA98F8697B7771:16:68364057";

ArrayList<Element> elements = new ArrayList();

Element seed;
String globalQuery = "libya"; // "+" (it means blank)

Element toSpawn;

PVector mousePos = new PVector();
HashMap<String, Element> elementMap = new HashMap();

void setup() {
  size(1280, 720, P3D);
  smooth(4);
  
  //Initialize the nytimes library
  TimesEngine.init(this, apiKey);
  
  //make the seed
  seed = new Element();
  seed.facetTerm = "QADDAFI, MUAMMAR EL-";
  seed.facetType = "per_facet";
  seed.tpos.set(width/2, height/2);
  seed.spawned = true;
  elements.add(seed);
  elementMap.put(seed.facetTerm, seed);
  spawnElement(seed);
}

void draw() {
  //Check to see if there's an element to spawn; if there is, spawn it
  if(toSpawn != null) {
    spawnElement(toSpawn); // act
    toSpawn = null; // empty bucket again
  }
  mousePos.set(mouseX, mouseY);
  
  background(0);
  for(Element e:elements) {
    e.update();
    e.render(); 
  }
}

void positionLine() {
  
  for(int i = 0; i < elements.size(); i++) {
    Element e = elements.get(i);
    float x = map(i, 0, elements.size(), 100, width - 100);
    float y = height/2;
    e.tpos.set(x, y);
    e.trot.set(0, 0, PI/2);
  }
}

void positionRing() {
  
  // Position all of the elements in a ring
  for(int i = 0; i < elements.size(); i++) {
    Element e = elements.get(i);
    if(e != seed) {
      float angle = map(i, 0, elements.size()-1, 0, TAU);
      float radius = e.generation * 100; //e.spawned ? 100:300;
      float x = seed.tpos.x + (cos(angle) * radius);
      float y = seed.tpos.y + (sin(angle) * radius);
      elements.get(i).trot.set(0, 0, angle);
      elements.get(i).tpos.set(x, y);
    }
  }
}

void spawnElement(Element e) {
  //Call our getFacets function for the element that we've passed in
  TimesFacetObject[] facets = getFacets(globalQuery, e.facetType, e.facetTerm);
  
  // Make a new element for all of our results
  for(int i = 1; i < facets.length; i++) { // in order to get rid of 'first qaddafi'
    
    if(!elementMap.containsKey(facets[i].term)) {
      // create a new element
      Element child = new Element(); 
      child.facetTerm = facets[i].term;
      child.facetType = e.facetType;
      child.count = facets[i].count;
      //child.tpos.set(random(width), random(height));
      child.birthOrder = elements.size();
      elements.add(child);
      e.connections.add(child);
      elementMap.put(child.facetTerm, child);
      child.generation = e.generation + 1;
    } 
    else {
      // use an old element
      Element child = elementMap.get(facets[i].term);
      e.connections.add(child);
      e.count += facets[i].count;
    }
  }
  //positionRing();
  positionLine();
}

TimesFacetObject[]  getFacets(String query, String facetType, String facetTerm) {
  //construct the search object
  TimesArticleSearch mySearch = new TimesArticleSearch();
   
  //add our search query
  mySearch.addQueries(query);
  //Restrict this search to only articles with a specific per_facet attached
  mySearch.addFacetQuery(facetType, facetTerm);
  mySearch.addFacets(facetType);
  //mySearch.addExtra("begin_date", "20001010");
  //mySearch.addFields(begin_date);// , "20001010"
  //mySearch.addFields(beginDate, date);
  mySearch.addExtra("begin_date", "20000101");
  mySearch.addExtra("end_date" ,  "20030115");

  //Do the search, This returns a TimesArticleSearchResponse
  TimesArticleSearchResult myResult = mySearch.doSearch();
  //Get the total results
  println(myResult.total);
  
  //Retrieve the requested facet objects
  // (These come back as an array of TimesFacetObject);
  TimesFacetObject[] facets = myResult.getFacetList(facetType);
  for (TimesFacetObject f:facets) {
    println(f.term, f.count); 
  }
  return facets;
}

void sortElements() {
  java.util.Collections.sort(elements);  //directly passing it
  positionLine();
}

void keyPressed() {
  if(key == 'o') {
    for(Element e:elements)  e.sortNumber = e.count;
    sortElements();
  }
  
  if(key == 'r')  {
    for(Element e:elements)  e.sortNumber = e.birthOrder;
    sortElements(); // order 
  }
}
