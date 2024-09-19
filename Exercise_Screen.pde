class ExerciseScreen extends Screen
{
  private Listbox exercises;
  private Button addExercise, back, selected, editButton, finishButton, removeButton;
  private Textbox nameBox;
  private String title;
  private int boxWidth = 200;
  private int boxHeight = 50;
  private boolean added;
  private Bar bar;
  private Errorbox errorBox, tooMuch;
  private boolean exists, isSelected, editing;
  private int selectedExercise;
  
  ExerciseScreen()
  {
    this.added = true;
    this.exists = false;
    this.isSelected = false;
    this.editing = false;
   
    exercises = new Listbox(0, 0, screenX, boxHeight + (boxHeight / 2), "", GREY, BLACK, BLACK, font, currentWorkout, index -> selectExercise(index), 8);
    bar = new Bar(0, 0, screenX, 200, exercises.getWorkout().getName(), LIGHT_BLUE, WHITE);
    exercises.setY(bar.getHeight());
    addExercise = new Button(screenX - (screenX / 8), screenY / 24, buttonWidth / 2, buttonHeight / 2, "ADD", WHITE, BLACK, BLACK, font, () -> addExercise());
    nameBox = new Textbox((screenX / 2) - (buttonWidth + (buttonWidth / 2)), (screenY / 2) - (buttonHeight / 2), buttonWidth * 3, buttonHeight, "ENTER NAME: ", WHITE, BLACK, BLACK, font);
    errorBox = new Errorbox((screenX / 2) - (buttonWidth + buttonWidth / 2), screenY / 2 - buttonHeight, buttonWidth * 3, buttonHeight, "This exercise already exists", BLUE, BLACK, WHITE, font);
    tooMuch = new Errorbox((screenX / 2) - (buttonWidth + buttonWidth / 2), (screenY / 2) - (buttonHeight), buttonWidth * 3, buttonHeight, "Max amount of exercises entered!", BLUE, BLACK, WHITE, font);
    selected = new Button((screenX / 2) - (boxWidth / 4), (screenY - (buttonHeight + buttonHeight / 6)), buttonWidth / 2, buttonHeight / 2, "SELECT", LIGHT_BLUE, BLACK, BLACK, font, () -> select());
    finishButton = new Button(screenX / 8, screenY / 24, buttonWidth / 2, buttonHeight / 2, "FINISH", WHITE, BLACK, BLACK, font, () -> finish());
    editButton = new Button((screenX / 2) - buttonWidth * 2, (screenY - (buttonHeight + buttonHeight / 6)), buttonWidth, buttonHeight / 2, "EDIT", LIGHT_BLUE, BLACK, BLACK, font,() -> editExercise());
    removeButton = new Button((screenX / 2) + buttonWidth, (screenY - (buttonHeight + buttonHeight / 6)), buttonWidth, buttonHeight / 2, "REMOVE", LIGHT_BLUE, BLACK, BLACK, font,() -> removeExercise());
    
    exerciseScreenButtons.add(addExercise); exerciseScreenButtons.add(selected); exerciseScreenButtons.add(errorBox.getOkButton()); exerciseScreenButtons.add(editButton); exerciseScreenButtons.add(removeButton);
    exerciseScreenButtons.add(tooMuch.getOkButton());
    exerciseScreenTextboxes.add(nameBox); 
    exerciseScreenListboxes.add(exercises);
    
    nameBox.setTextLength(30);
    editButton.setTextSize(20); finishButton.setTextSize(20);
    removeButton.setTextSize(20);
    nameBox.setTextSize(28);
    errorBox.setTextSize(30); tooMuch.setTextSize(30); addExercise.setTextSize(20); selected.setTextSize(20);
  }
  public boolean getAdded()
  {
    return this.added;
  }
  public void setAdded(boolean added)
  {
    this.added = added;
  }
  public boolean getExists()
  {
    return this.exists;
  }
  public boolean getIsSelected()
  {
    return this.isSelected;
  }
  public void setIsSelected(boolean isSelected)
  {
    this.isSelected = isSelected;
  }
  public void setExists(boolean exists)
  {
    this.exists = exists;
  }
  public boolean getEditing()
  {
    return this.editing;
  }
  public void setEditing(boolean editing)
  {
    this.editing = editing;
  }
   
  public void draw()
  {
    background(WHITE);
    bar.setTextSize(80);
    bar.setLabel(currentWorkout.getName());
    bar.draw();
    addExercise.draw();
    exercises.draw();
    selected.draw();
    editButton.draw();
    removeButton.draw();
    if(tooMuch.getError())
    {
      tooMuch.draw();
    }
    if(nameBox.getIsEditable())
    {
      nameBox.draw();
    }
    else if(!this.getAdded())
    {
      for(int i = 0; i < exercises.getWorkout().getExercises().size() ; i++)
      {
        String name = exercises.getWorkout().getExercises().get(i).getName();
        if(name.toLowerCase().equals(nameBox.getText().toLowerCase()))
        {
          this.errorBox.setError(true);
        }
      }
      if(!this.errorBox.getError())
      {
        exercises.addExercise(nameBox.getText());
        setWorkout();
        addExercise.setClicked(false);
      }
      else
      {
        errorBox.draw();
      }
      nameBox.setText("");
      this.setAdded(true);
    }
    else if(this.getEditing())
    {
      for(int i = 0; i < exercises.getWorkout().getExercises().size() ; i++)
      {
        String name = exercises.getWorkout().getExercises().get(i).getName();
        if(name.toLowerCase().equals(nameBox.getText().toLowerCase()))
        {
          this.errorBox.setError(true);
        }
      }
      if(!this.errorBox.getError())
      {
        exercises.getWorkout().getExercises().get(exercises.getSelected()).setName(nameBox.getText());
        setWorkout();
      }
      else
      {
        errorBox.draw();
      }
      nameBox.setText("");
      this.setEditing(false);
    }
    errorBox.draw();
    if(selectScreen.creatingWorkout)
    {
      finishButton.draw();
      if(!exerciseScreenButtons.contains(finishButton))
      {
        exerciseScreenButtons.add(finishButton);
      }
    }
  }
  public void selectExercise(int index)
  {
    selectedExercise = index;
    if(exercises.getWorkout().getExercises().size() < index || index < 0 || exercises.getWorkout().getExercises().size() == 0) { return;}
    else if(this.getIsSelected())
    {
      currentExercise = exercises.getWorkout().getExercises().get(index);
      editScreen.setBox.setExercise(currentWorkout.getSpecificExercise(currentExercise.getName()));
      editScreen.setBox.setupScrollbar();
      exercises.setSelected(-1);
      currentScreen = editScreen;
    }
  }
  public void addExercise()
  {
    if(exercises.getWorkout().getExercises().size() >= exercises.getVisibleOptions())
    {
      this.tooMuch.setError(true);
    }
    else
    {
      nameBox.setIsEditable(true);
      this.setAdded(false);
    }
  }
  public void select()
  {
    if(currentScreen == exerciseScreen && !selectScreen.creatingWorkout)
    {
      this.setIsSelected(!this.getIsSelected());
      if(this.getIsSelected())
      {
        this.selectExercise(exercises.getSelected());
      }
    }
  }
  public void finish()
  {
    selectScreen.setCreatingWorkout(false);
    saveButtonWorkouts(selectScreen.workouts, "workouts.json");
    exerciseScreenButtons.remove(finishButton);
    currentScreen = selectScreen;
  }
  public void editExercise()
  {
    if(exercises.getSelected() >= 0)
    {
      nameBox.setIsEditable(true);
      this.setEditing(true);
    }
  }
  public void removeExercise()
  {
    if(exercises.getSelected() >= 0)
    {
      exercises.removeExercise(exercises.getSelected());
      setWorkout();
    }
  }
}
