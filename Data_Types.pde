class Workout
{
  private String name;
  private ArrayList<Exercise> exercises;
  
  Workout(String name)
  {
    this.name = name;
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
  public ArrayList<Exercise> getExercises()
  {
    return this.exercises;
  }
  public void addExercise(String name)
  {
    this.exercises.add(new Exercise(name));
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
  public void setName()
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
    return "WEIGHT: " + weight + " REPS: " + reps;
  }
}
