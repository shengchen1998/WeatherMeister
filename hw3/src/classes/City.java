package classes;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class City {

@SerializedName("id")
@Expose
public int id;
@SerializedName("name")
@Expose
public String name;
@SerializedName("country")
@Expose
public String country;
@SerializedName("coord")
@Expose
public Coord coord;

}
