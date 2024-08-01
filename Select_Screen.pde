class SelectScreen extends Screen
{
  private ArrayList<Button> workoutButtons;
  private ArrayList<Workout> workouts;
  private Button createWorkout;
  private int buttonWidth = 200;
  private int buttonHeight = 200;
  private int margin = 300;
  private Textbox nameBox;
  private boolean created;
  private Bar bar;
  
  SelectScreen()
  {
    createWorkout = new Button((screenX / 2) - (buttonWidth / 2), (screenY - buttonHeight / 2) - (margin / 4), buttonWidth, buttonHeight / 2, "CREATE WORKOUT", LIGHT_BLUE, BLACK, BLACK, font,() -> createWorkout());
    allButtons.add(createWorkout);
    workoutButtons = new ArrayList<Button>();
    workouts = new ArrayList<Workout>();
    nameBox = new Textbox((screenX / 2) - buttonWidth, (screenY / 2) - (buttonHeight / 2), buttonWidth * 2, buttonHeight, "ENTER NAME: ", WHITE, BLACK, BLACK, font);
    allTextboxes.add(nameBox);
    this.created = true;
    bar = new Bar(0, 0, screenX, 200, LIGHT_BLUE);
  }
  public boolean getCreated()
  {
    return this.created;
  }
  public void setCreated(boolean created)
  {
    this.created = created;
  }
  
  public void createWorkout()
  {
    nameBox.setIsEditable(true);
    this.setCreated(false);
  }
  public void selectWorkout()
  {
    for(int i = 0; i < workoutButtons.size(); i++)
    {
      Button button = workoutButtons.get(i);
      if(button.getClicked())
      {
        currentWorkout = workouts.get(i);
      }
      button.setClicked(false);
    }
    currentScreen = exerciseScreen;
  }
  public void draw()
  {
    background(WHITE);
    for(int i = 0; i < workoutButtons.size(); i++)
    {
      Button button = workoutButtons.get(i);
      button.setTextSize(40);
      if(button != null)
      {
        button.draw();
      }
    }
    createWorkout.setTextSize(20);
    createWorkout.draw();
    bar.draw();
    textAlign(CENTER, CENTER);
    fill(WHITE);
    textFont(font);
    textSize(80);
    text("SELECT WORKOUT", screenX / 2, 100);
    
    if(nameBox.getIsEditable())
    {
      nameBox.setTextSize(28);
      nameBox.draw();
    }
    else if(!this.getCreated())
    {
      Button workoutButton = new Button((workoutButtons.size() * margin) + (workoutButtons.size() < 0 ? margin : margin / 3), (screenY / 2) - buttonHeight, buttonWidth, buttonHeight, nameBox.getText(), LIGHT_BLUE, BLACK , BLACK, font, () -> selectWorkout());
      workoutButtons.add(workoutButton);
      allButtons.add(workoutButton);
      Workout newWorkout = new Workout(nameBox.getText());
      workouts.add(newWorkout);
      this.setCreated(true);
      nameBox.setText("");
    }
  }
}
