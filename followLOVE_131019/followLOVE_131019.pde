// unfolding maps
import processing.opengl.*;
import processing.core.PGraphics;
import codeanticode.glgraphics.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.marker.SimplePointMarker;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.utils.ScreenPosition;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.providers.MapBox;
import de.fhpotsdam.unfolding.providers.MBTilesMapProvider; // add .jar file
import de.fhpotsdam.unfolding.providers.Microsoft;
import de.fhpotsdam.unfolding.providers.OpenStreetMap;
import de.fhpotsdam.unfolding.providers.StamenMapProvider;

// twitter (add .jar file): oauth info & access token info
static String OAuthConsumerKey = "VVIy5oJeMX2yFQCWEIOdZg";
static String OAuthConsumerSecret = "HSh2RyGtUfuNZdbJwTVJNsu7xPn4HBQUPqRQWfsA";
static String AccessToken = "159058059-NSkrkHQP8YT2E33vSvs3xucJEtLRa63u0CnLRELj";
static String AccessTokenSecret = "gV8k9tWSiqBqUavY5HwV7Gi0YnjbHZWUegifu6aXLo";

TwitterStream twitter = new TwitterStreamFactory().getInstance();
UnfoldingMap map;
SimplePointMarker myMarker;
SimplePointMarker havasMarker;

float lat = 0;
float lon = 0;
PFont font;
int cntColor = 0;
int opac = 200;
color color_set[] = new color[21];

// panning
boolean TwitterOn = false;
boolean StartOn = false;
String username;
String keywords[] = {"love"};

ArrayList myFire = new ArrayList();
ArrayList myTweets;
Time myTime;

Location temp_location;
Location pLocation;
Location centerLocation = new Location(30, 0); // lat lon
Location havasLocation = new Location(40.722912, -74.007606);
Location firstLocation = new Location(41.754586, -82.127606);
Location secondLocation = new Location(37.319828, -26.880493);

PVector pan_pos = new PVector();  // location info (x -> lon, y -> lat)
PVector pan_tpos = new PVector(); // location info (x -> lon, y -> lat)
int cntStop = 0;
float rate = 0.03; // for lerp

//static public void main(String args[]) {
//  Frame frame = new Frame("testing");
//  frame.setUndecorated(true);
//  // The name "sketch_name" must match the name of your program
//  PApplet applet = new followLOVE_131012_pan();
//  frame.add(applet);
//  applet.init();
//  frame.setBounds(0, 0, 1920*2, 1080); 
//  frame.setVisible(true);
//}

void setup() {
  /* PROJECTION */
//  size(1920*2, 1080, GLConstants.GLGRAPHICS); // 800, 600 // 1920, 1080
//  font = createFont("/Users/madscience/Desktop/DROP/SansSerif-48.vlw",48);
//  //font = createFont("/Users/madscience/Desktop/DROP/DS-DIGIB.TTF", 32); 
//  String connStr = "jdbc:sqlite:" + ("/Users/madscience/Desktop/DROP/basicMap.mbtiles");
  
  /* MONITOR */
  //size(int(1920*0.73), int(540*0.73), GLConstants.GLGRAPHICS);
  size(1280, 720, GLConstants.GLGRAPHICS);
  //size(1280,720, GLConstants.GLGRAPHICS);
   font = createFont("SansSerif-48.vlw", 48);
////  //font = createFont("/Users/youjinshin/Documents/TwitterViz/followLove_131008_pan/data/DS-DIGIB.TTF", 32);
  String connStr = "jdbc:sqlite:" + ("/Users/youjinshin/Documents/Map/basicMap.mbtiles");

  // unfolding map
  map = new UnfoldingMap(this, new MBTilesMapProvider(connStr));
  MapUtils.createDefaultEventDispatcher(this, map);
  map.setTweening(true);
  map.zoomAndPanTo(centerLocation, 3);
  
  pan_pos.x = 0;
  pan_pos.y = 30;
  pan_tpos.x = 0;
  pan_tpos.y = 30;

  // twitter
  connectTwitter();
  twitter.addListener(listener);
  twitter.filter(new FilterQuery().track(keywords));
  myTweets = new ArrayList();
  myTime = new Time();
  pLocation = havasLocation;
  colorMode(HSB, 360, 100, 100);
  getColor();
}

void draw() {
  noCursor();
  imageMode(CORNER);
  directionalLight(166, 166, 196, -60, -60, -60);
  background(0);
  map.draw();

  if (TwitterOn) { // when new twitter comes
    color tcolor = color_set[cntColor];
    Fireworks f = new Fireworks();
    myFire.add(f);
    
    Tweet t = new Tweet();
    t.myLocation = temp_location;
    t.pLocation = pLocation;
    t.username = username;
    t.tcolor = tcolor;
    t.lat = lat;
    t.lon = lon;
    myTweets.add(t);
    
    StartOn = true;
    cntStop = 0;
    rate = 0.03;
    cntColor++;
  } else {
    cntStop++;
    if(cntStop % 100 == 0) {
      pan_tpos.x = random(-60, 60);
      pan_tpos.y = random(-30, 30);
      rate = 0.005;
    }
  }
   
  
  if (StartOn) {
    for (int i = 0; i < myTweets.size(); i++) {
      Tweet t = (Tweet) myTweets.get(i); 
      Fireworks f = (Fireworks) myFire.get(i);
      if (i > 1) {     
        Tweet tp = (Tweet) myTweets.get(i-1);
        if (tp.isDraw == true) t.display(i, f);
        if (t.isDraw == false) {
            pan_tpos.x = t.lon;
            pan_tpos.y = t.lat;
        }
      } else {
        t.display(i, f);
      }
      pLocation = t.myLocation;
    }
  }  
  if (myTweets.size() > 10) {
    myTweets.remove(0);
    myFire.remove(0);
    
  }
  if (cntColor > 10) cntColor = 0;
  TwitterOn = false;
  myTime.display();
  
  //pan_pos.lerp(pan_tpos, rate);
  float dx = pan_tpos.x - pan_pos.x;
  float dy = pan_tpos.y - pan_pos.y;
  pan_pos.x += dx * rate;
  pan_pos.y += dy * rate;
  
  Location target = new Location(pan_pos.y, pan_pos.x);
  map.panTo(target);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void connectTwitter() {
  twitter.setOAuthConsumer(OAuthConsumerKey, OAuthConsumerSecret);
  AccessToken accessToken = loadAccessToken();
  twitter.setOAuthAccessToken(accessToken);
}

private static AccessToken loadAccessToken() {
  return new AccessToken(AccessToken, AccessTokenSecret);
}

StatusListener listener = new StatusListener() {
  public void onStatus(Status status) {
    lon = (float) status.getGeoLocation().getLongitude();
    lat = (float) status.getGeoLocation().getLatitude();

    Location myLocation = new Location(lat, lon);
    temp_location = myLocation;
    username = status.getUser().getScreenName();
    TwitterOn = true;
  }
  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
    System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
  }
  public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
    System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
  }
  public void onScrubGeo(long userId, long upToStatusId) {
    System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }
  public void onException(Exception ex) {
    ex.printStackTrace();
  }
  public void onStallWarning(StallWarning warning) {
  }
};

void getColor() {
  color_set[0] = color(48, 77, 100, opac);
  color_set[1] = color(198, 66, 65, opac);
  color_set[2] = color(91, 70, 76, opac);
  color_set[3] = color(323, 51, 64, opac);
  color_set[4] = color(18, 84, 98, opac);
  color_set[5] = color(7, 78, 88, opac);
  color_set[6] = color(40, 91, 100, opac);
  color_set[7] = color(192, 82, 84, opac);
  color_set[8] = color(124, 57, 56, opac);
  color_set[9] = color(295, 65, 61, opac);
  color_set[10] = color(32, 80, 99, opac);
  color_set[11] = color(48, 77, 100, opac);
  color_set[12] = color(198, 66, 65, opac);
  color_set[13] = color(91, 70, 76, opac);
  color_set[14] = color(323, 51, 64, opac);
  color_set[15] = color(18, 84, 98, opac);
  color_set[16] = color(7, 78, 88, opac);
  color_set[17] = color(40, 91, 100, opac);
  color_set[18] = color(192, 82, 84, opac);
  color_set[19] = color(124, 57, 56, opac);
  color_set[20] = color(295, 65, 61, opac);
}

