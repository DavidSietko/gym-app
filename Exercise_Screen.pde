class ExerciseScreen extends Screen
{
  private Listbox exercises;
  private Button addExercise;
  private Button back;
  private Textbox nameBox;
  private String title;
  private int boxWidth = 200;
  private int boxHeight = 50;
  private boolean added;
  private Bar bar;
  
  ExerciseScreen()
  {
    this.added = true;
   
    exercises = new Listbox((screenX / 2) - (boxWidth / 2), screenY / 4, boxWidth, boxHeight, "", GREY, BLACK, BLACK, font, currentWorkout, index -> selectExercise(index), 10);
    addExercise = new Button(screenX - (screenX / 4), screenY / 18, buttonWidth / 2, buttonHeight / 2, "ADD", WHITE, BLACK, BLACK, font, () -> addExercise());
    nameBox = new Textbox((screenX / 2) - buttonWidth, (screenY / 2) - (buttonHeight / 2), buttonWidth * 2, buttonHeight, "ENTER NAME: ", WHITE, BLACK, BLACK, font);
    bar = new Bar(0, 0, screenX, 200, LIGHT_BLUE);
    
    allButtons.add(addExercise);
    allTextboxes.add(nameBox);
    allListBoxes.add(exercises);
  }
  public boolean getAdded()
  {
    return this.added;
  }
  public void setAdded(boolean added)
  {
    this.added = added;
  }
  public void draw()
  {
    background(WHITE);
    bar.draw();
    addExercise.draw();
    exercises.draw();
    if(nameBox.getIsEditable())
    {
      nameBox.setTextSize(28);
      nameBox.draw();
    }
    else if(!this.getAdded())
    {
      exercises.addExercise(nameBox.getText());
      nameBox.setText("");
      this.setAdded(true);
    }
    
  }
  public void selectExercise(int index)
  {
    currentExercise = exercises.getWorkout().getExercises().get(index);
  }
  public void addExercise()
  {
    nameBox.setIsEditable(true);
    this.setAdded(false);
  }
}
