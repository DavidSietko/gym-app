class Workout
{
  private String name;
  private String date;
  private ArrayList<Exercise> exercises;
  
  Workout(String name, String date)
  {
    this.name = name;
    this.date = date;
    exercises = new ArrayList<Exercise>();
  }
  public String getName()
  {
    return this.name;
  }
  public void setName(String name)
  {
    this.name = name;
  }
  public String getDate()
  {
    return this.date;
  }
  public void setDate(String date)
  {
    this.date = date;
  }
  public ArrayList<Exercise> getExercises()
  {
    return this.exercises;
  }
  public void addExercise(String name)
  {
    this.exercises.add(new Exercise(name));
  }
  public void removeExercise(Exercise exercise)
  {
    this.exercises.remove(exercise);
  }
  public Exercise getSpecificExercise(String name)
  {
    Exercise exercise = new Exercise("");
    for(int i = 0; i <this.exercises.size(); i++)
    {
      if(this.exercises.get(i).getName() == name)
      {
        exercise = this.exercises.get(i);
      }
    }
    return exercise;
  }
  
  public JSONObject toJSON()
  {
    JSONObject json = new JSONObject();
    json.setString("name", this.name);
    json.setString("date", this.date);
    JSONArray jsonExercises = new JSONArray();
    for(Exercise exercise : this.exercises)
    {
      jsonExercises.append(exercise.toJSON());
    }
    json.setJSONArray("exercises", jsonExercises);
    return json;
  }
  public Workout fromJSON(JSONObject json)
  {
    String name = json.getString("name");
    String date = json.getString("date");
    Workout workout = new Workout(name, date);
    JSONArray jsonExercises = json.getJSONArray("exercises");
    for(int i = 0; i < jsonExercises.size(); i++)
    {
      Exercise exercise = new Exercise("");
      workout.getExercises().add(exercise.fromJSON(jsonExercises.getJSONObject(i)));
    }
    return workout;
  }
}

class Exercise
{
  private String name;
  private ArrayList<Set> sets;
  
  Exercise(String name)
  {
    this.name = name;
    this.sets = new ArrayList<Set>();
  }
  public String getName()
  {
    return this.name;
  }
  public void setName(String name)
  {
    this.name = name;
  }
  public ArrayList<Set> getSets()
  {
    return this.sets;
  }
  public void addSet(int weight, int reps)
  {
    this.sets.add(new Set(weight, reps));
  }
  public void clearSets()
  {
    this.getSets().clear();
  }
  
  public JSONObject toJSON()
  {
    JSONObject json = new JSONObject();
    json.setString("name", this.name);
    JSONArray jsonSets = new JSONArray();
    for(Set set : this.sets)
    {
      jsonSets.append(set.toJSON());
    }
    json.setJSONArray("sets", jsonSets);
    return json;
  }
   Exercise fromJSON(JSONObject json)
  {
    String name = json.getString("name");
    Exercise exercise = new Exercise(name);
    JSONArray jsonSets = json.getJSONArray("sets");
    for(int i = 0; i < jsonSets.size(); i++)
    {
      Set set = new Set(0, 0);
      exercise.getSets().add(set.fromJSON(jsonSets.getJSONObject(i)));
    }
    return exercise;
  }
  
}

class Set
{
  private int weight, reps;
  
  Set(int weight, int reps)
  {
    this.weight = weight;
    this.reps = reps;
  }
  public int getWeight()
  {
    return this.weight;
  }
  public void setWeight(int weight)
  {
    this.weight = weight;
  }
  public int getReps()
  {
    return this.reps;
  }
  public void setReps(int reps)
  {
    this.reps = reps;
  }
  public String toStr()
  {
    return "WEIGHT(kg):   " + weight + "   REPS:  " + reps;
  }
  
  public JSONObject toJSON()
  {
    JSONObject json = new JSONObject();
    json.setInt("weight", this.weight);
    json.setInt("reps", this.reps);
    return json;
  }
  Set fromJSON(JSONObject json)
  {
    int weight = json.getInt("weight");
    int reps = json.getInt("reps");
    return new Set(weight, reps);
  }
}
