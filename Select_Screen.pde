class SelectScreen extends Screen
{
  private ArrayList<Button> workoutButtons;
  private ArrayList<String> buttonNames;
  private ArrayList<Workout> workouts;
  private Workout workout;
  String fileName = "buttons.json";
  private Button createWorkout;
  private int buttonWidth = 250;
  private int buttonHeight = 200;
  private int margin = 308;
  private int buttonMargin = 100;
  private Textbox nameBox;
  private boolean created, removing, creatingWorkout;
  private Bar bar;
  private Button removeButton;
  
  SelectScreen()
  {
    createWorkout = new Button((screenX / 2) - (buttonWidth + buttonMargin), (screenY - buttonHeight / 2) - (margin / 4), buttonWidth, buttonHeight / 2, "CREATE WORKOUT", LIGHT_BLUE, BLACK, BLACK, font,() -> createWorkout());
    removeButton = new Button((screenX / 2) + buttonMargin, (screenY - buttonHeight / 2) - (margin / 4), buttonWidth, buttonHeight / 2, "REMOVE", LIGHT_BLUE, BLACK, BLACK, font,() -> removeButton());
    selectScreenButtons.add(createWorkout); selectScreenButtons.add(removeButton);
    workoutButtons = new ArrayList<Button>();
    workouts = loadButtonWorkouts("workouts.json");
    buttonNames = loadButtons(fileName);
    for(int i = 0; i < buttonNames.size(); i++)
    {
      workoutButtons.add(new Button((workoutButtons.size() < 6  ? (workoutButtons.size() * margin) + (workoutButtons.size() < 0 ? margin : margin / 3) : ((workoutButtons.size() - 6) * margin) + (workoutButtons.size() == 5 ? margin : margin / 3)) , (screenY / 2) - buttonHeight + (workoutButtons.size() < 6  ? 0 : margin), buttonWidth, buttonHeight, buttonNames.get(i), LIGHT_BLUE, BLACK , BLACK, font, () -> selectWorkout()));
      selectScreenButtons.add(workoutButtons.get(i));
    }
    nameBox = new Textbox((screenX / 3) - buttonWidth / 5, (screenY / 2) - (buttonHeight / 2), buttonWidth * 3, buttonHeight, "ENTER NAME: ", WHITE, BLACK, BLACK, font);
    selectScreenTextboxes.add(nameBox);
    this.created = true;
    this.removing = false;
    this.creatingWorkout = false;
    bar = new Bar(0, 0, screenX, 200, "SELECT WORKOUT", LIGHT_BLUE, WHITE);
    
    nameBox.setTextSize(28);
    nameBox.setTextLength(30);
    removeButton.setTextSize(20);
    createWorkout.setTextSize(20);
    bar.setTextSize(80);
  }
  public boolean getCreated()
  {
    return this.created;
  }
  public void setCreated(boolean created)
  {
    this.created = created;
  }
  public boolean getRemoving()
  {
    return this.removing;
  }
  public void setRemoving(boolean removing)
  {
    this.removing = removing;
  }
  public boolean getCreatingWorkout()
  {
    return this.creatingWorkout;
  }
  public void setCreatingWorkout(boolean creatingWorkout)
  {
    this.creatingWorkout = creatingWorkout;
  }
  
  public void createWorkout()
  {
    nameBox.setIsEditable(true);
    this.setCreated(false);
  }
  public void removeButton()
  {
    this.setRemoving(!this.getRemoving());
  }
  public void selectWorkout()
  {
    for(int i = 0; i < workoutButtons.size(); i++)
    {
      Button button = workoutButtons.get(i);
      if(button.getClicked() && !this.removing)
      {
        Workout thisWorkout = workouts.get(i);
        currentWorkout = new Workout( thisWorkout.getName(), currentDate.toString());
        for(int j = 0; j < thisWorkout.getExercises().size(); j++)
        {
          currentWorkout.getExercises().add(new Exercise(thisWorkout.getExercises().get(j).getName()));
        }
        exerciseScreen.exercises.setWorkout(currentWorkout);
        exerciseScreen.exercises.setupScrollbar();
        currentScreen = exerciseScreen;
        button.setClicked(false);
      }
      else if(this.removing && button.getClicked())
      {
        workoutButtons.remove(button);
        workouts.remove(i);
      }
    }
  }
  public void draw()
  {
    background(WHITE);
    for(int i = 0; i < workoutButtons.size(); i++)
    {
      Button button = workoutButtons.get(i);
      button.setTextSize(32);
      button.draw();
    }
    createWorkout.draw();
    removeButton.draw();
    bar.draw();
    
    if(nameBox.getIsEditable())
    {
      nameBox.draw();
    }
    else if(!this.getCreated())
    {
      this.setCreatingWorkout(true);
      Button workoutButton = new Button((workoutButtons.size() < 6  ? (workoutButtons.size() * margin) + (workoutButtons.size() < 0 ? margin : margin / 3) : ((workoutButtons.size() - 6) * margin) + (workoutButtons.size() == 5 ? margin : margin / 3)) , (screenY / 2) - buttonHeight + (workoutButtons.size() < 6  ? 0 : margin), buttonWidth, buttonHeight, nameBox.getText(), LIGHT_BLUE, BLACK , BLACK, font, () -> selectWorkout());
      workoutButtons.add(workoutButton);
      workout = new Workout(nameBox.getText(), "");
      workouts.add(workout);
      currentWorkout = workout;
      exerciseScreen.exercises.setWorkout(currentWorkout);
      selectScreenButtons.add(workoutButton);
      createWorkout.toggleClick();
      this.setCreated(true);
      nameBox.setText("");
      currentScreen = exerciseScreen;
    }
    if(this.removing)
    {
      fill(BLUE);
      textAlign(LEFT, BOTTOM);
      textSize(32);
      text(("CLICK ON A WORKOUT TO REMOVE IT"), 0 + buttonMargin, screenY - buttonMargin);
    }
  }
}
