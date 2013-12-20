IntDict d = new IntDict();
d.set("blue", 10);
d.increment("blue");
d.increment("red");
d.increment("black");
d.increment("red");

println(d.keyArray());
println(d.get("blue"));
println(d.get("red"));
println(d.get("black"));

println(d);
