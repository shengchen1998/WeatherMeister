package classes;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Main
{
	@SerializedName("temp")
	@Expose
	public double temp;
	@SerializedName("pressure")
	@Expose
	public double pressure;
	@SerializedName("humidity")
	@Expose
	public double humidity;
	@SerializedName("temp_min")
	@Expose
	public double tempMin;
	@SerializedName("temp_max")
	@Expose
	public double tempMax;
}
