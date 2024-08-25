import java.nio.file.*;


public void saveButtons(ArrayList<Button> buttons, String fileName)
{
  String dataPath = path + fileName;
  JSONArray jsonArray = new JSONArray();
  for(Button button : buttons)
  {
    jsonArray.append(button.toJSON());
  }
  JSONObject json = new JSONObject();
  json.setJSONArray("buttons", jsonArray);
  saveJSONObject(json, dataPath);
}
public ArrayList<String> loadButtons(String fileName)
{
  ArrayList<String> buttonNames = new ArrayList<String>();
  try
  {
    String dataPath = path + fileName;
    JSONObject json = loadJSONObject(dataPath);
    JSONArray jsonArray = json.getJSONArray("buttons");
    for(int i = 0; i < jsonArray.size(); i++)
    {
        Button button = new Button(0, 0, 0, 0, "", BLACK, BLACK, BLACK, font, () -> nothing());
      buttonNames.add(button.fromJSON(jsonArray.getJSONObject(i)));
    }
  }
  catch(Exception e)
  {
    
  }
  return buttonNames;
}
public void nothing() {}

public void saveButtonWorkouts(ArrayList<Workout> workouts, String fileName)
{
  String dataPath = path + fileName;
  JSONArray jsonArray = new JSONArray();
  for(Workout workout : workouts)
  {
    jsonArray.append(workout.toJSON());
  }
  JSONObject json = new JSONObject();
  json.setJSONArray("workouts", jsonArray);
  saveJSONObject(json, dataPath);
}
public ArrayList<Workout> loadButtonWorkouts(String fileName)
{
  String dataPath = path + fileName;
  ArrayList<Workout> workouts = new ArrayList<Workout>();
  try
  {
    JSONObject json = loadJSONObject(dataPath);
    JSONArray jsonArray = json.getJSONArray("workouts");
    for(int i = 0; i < jsonArray.size(); i++)
    {
      Workout workout = new Workout("", "");
      workouts.add(workout.fromJSON(jsonArray.getJSONObject(i)));
    }
  }
  catch(Exception e)
  {
    
  }
  return workouts;
}
public void saveWorkout(Workout workout)
{
  String fileName =  path + workout.getDate() + ".json";
  JSONObject json = workout.toJSON();
  saveJSONObject(json, fileName);
}
public Workout loadWorkout(String date)
{
  String fileName = path + date + ".json";
  Workout workout = new Workout("","");
  try
  {
    JSONObject json = loadJSONObject(fileName);
    return workout.fromJSON(json);
  }
  catch(Exception e)
  {
    return workout;
  }
}
public void deleteWorkout(String fileName)
{
  try
  {
    Path filePath = Paths.get(dataPath(fileName));
    Files.delete(filePath);
    println("deleted");
  }
  catch(IOException e)
  {
    println("didnt delete");
  }
}
public void setWorkout()
{
  for(int i = 0; i < selectScreen.workouts.size(); i++)
 {
   Workout w = selectScreen.workouts.get(i);
   if(w.getName().equals(currentWorkout.getName()))
   {
     selectScreen.workouts.set(i, currentWorkout);
   }
 }
}
