import blprnt.nytimes.*;

// per_facet (person) , org_facet (organization), geo_facet (geographic area)
// des_facet (description), publication_year, publication_month, page_facet
// http://developer.nytimes.com/docs/read/article_search_api

/* - - - control - - - */
int controlCnt = 1; // 0, 1, 2

String apiKey = "0286F7A9A25EF5B036AA98F8697B7771:16:68364057";

ArrayList<Element> elements =  new ArrayList();
String globalQuery = "happiness";
Element seed;
Element toSpawn;

PVector mousePos = new PVector();
HashMap<String, Element> elementMap = new HashMap();

int generationCnt = 0;
int generationLim = 0;
boolean clickedMouse = false;

void setup() {
  size(1280, 720, P3D);
  background(0);
  smooth(4);
  
  //Initialize the nytimes library
  TimesEngine.init(this, apiKey);
  
  //Make the seed
  seed = new Element();
  seed.facetTerm = "CHILDREN AND YOUTH";
  seed.facetType = "des_facet";
  seed.tpos.set(width/2, height/2);
  seed.spawned = true;
  elements.add(seed);
  elementMap.put(seed.facetTerm, seed); // why hashMap?
  spawnElement(seed);
  
  generationLim = elements.size();
}

void draw() {
  
  
  //Check to see if there's an element to spawn; if there is, spawn it
  /*
  if(toSpawn != null) {
    spawnElement(toSpawn); // act
    toSpawn = null; // empty bucket again
  }  
  mousePos.set(mouseX, mouseY);
  */
  
  if(clickedMouse) {
  if(generationCnt<generationLim && frameCount%20==0) {
    Element e = elements.get(generationCnt);
    //e.spawned = true;
    spawnElement(e);
    generationCnt++;
  }
  //println("cnt: " + generationCnt);
  //println("frameCount: " + frameCount);

  background(0);
  for(Element e:elements) {
    e.update();
    e.render();
  }
  fill(80);
  if(controlCnt == 0) text("1981 - 1991", width*0.9, height*0.9);
  if(controlCnt == 1) text("1991 - 2001", width*0.9, height*0.9);
  if(controlCnt == 2) text("2001 - 2011", width*0.9, height*0.9);
  }
}

void mouseClicked() {
  clickedMouse = true;
}

void positionRing() {
  //position all of the elements in a ring
  for(int i = 0; i < elements.size(); i++) {
    Element e = elements.get(i);
    if(e != seed) {
      float angle = map(i, 0, elements.size() - 1, 0, TAU);
      //float radius = e.generation * 100;
      float radius = e.spawned ? 100: 280;
      float x = seed.tpos.x + (cos(angle) * radius);
      float y = seed.tpos.y + (sin(angle) * radius);
      elements.get(i).trot.set(0, 0, angle);
      elements.get(i).tpos.set(x, y);
    }
  }
}

void spawnElement(Element e) {
  //call our getFacets function for the element that we've passed in
  TimesFacetObject[] facets = getFacets(globalQuery, e.facetType, e.facetTerm);
  
  //make a new element for all of our results
  for(int i = 1; i < facets.length; i++) { //to get rid of first 'facetTerm'
    
    if(!elementMap.containsKey(facets[i].term)) {
      //create a new element
      Element child = new Element();
      child.facetTerm = facets[i].term;
      child.facetType = e.facetType;
      elements.add(child);
      e.connections.add(child);
      elementMap.put(child.facetTerm, child);
      child.generation = e.generation + 1;
    }
    else {
      //use an old element
      Element child = elementMap.get(facets[i].term);
      child.networkedNum++;
      e.connections.add(child);
    }
  }
  positionRing();
}

TimesFacetObject[] getFacets(String query, String facetType, String facetTerm) {
  //construct the search object
  TimesArticleSearch mySearch = new TimesArticleSearch();
  
  //add our search query
  mySearch.addQueries(query);
  //rescrict this search to only articles with a specific facet attached
  mySearch.addFacetQuery(facetType, facetTerm);
  mySearch.addFacets(facetType);
  
  if(controlCnt == 0) {
    mySearch.addExtra("begin_date", "19810101");
    mySearch.addExtra("end_date", "19910101");
  }
  if(controlCnt == 1) {
    mySearch.addExtra("begin_date", "19910101");
    mySearch.addExtra("end_date", "20010101");
  }
  if(controlCnt == 2) {
    mySearch.addExtra("begin_date", "20010101");
    mySearch.addExtra("end_date", "20110101");
  }
  
  //do the search, this returns a TimesArticleSearchResponse
  TimesArticleSearchResult myResult = mySearch.doSearch();
  println(myResult.total); 
  
  //Retrieve the requested facet objects
  //these come back as an array of TimesFacetObject
  TimesFacetObject[] facets = myResult.getFacetList(facetType);
  for(TimesFacetObject f:facets) {
    println(f.term, f.count);
  }
  return facets; 
}
