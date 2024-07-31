class ExerciseScreen extends Screen
{
  private Listbox exercises;
  private Button addExercise;
  private Button back;
  private String title;
  private int boxWidth = 200;
  private int boxHeight = 50;
  
  ExerciseScreen()
  {
    exercises = new Listbox((screenX / 2) - (boxWidth / 2), screenY / 5, boxWidth, boxHeight, "", GREY, BLACK, BLACK, font, currentWorkout,
  }
  public void draw()
  {
    
  }
}
