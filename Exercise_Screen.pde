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
  private Errorbox errorBox;
  private boolean exists, isSelected, editing;
  private int selectedExercise;
  
  ExerciseScreen()
  {
    this.added = true;
    this.exists = false;
    this.isSelected = false;
    this.editing = false;
   
    exercises = new Listbox((screenX / 2) - (boxWidth), screenY / 3, boxWidth * 2, boxHeight, "", GREY, BLACK, BLACK, font, currentWorkout, index -> selectExercise(index), 10);
    addExercise = new Button(screenX - (screenX / 8), screenY / 18, buttonWidth / 2, buttonHeight / 2, "ADD", WHITE, BLACK, BLACK, font, () -> addExercise());
    nameBox = new Textbox((screenX / 2) - (buttonWidth + (buttonWidth / 2)), (screenY / 2) - (buttonHeight / 2), buttonWidth * 3, buttonHeight, "ENTER NAME: ", WHITE, BLACK, BLACK, font);
    bar = new Bar(0, 0, screenX, 200, exercises.getWorkout().getName(), LIGHT_BLUE, WHITE);
    errorBox = new Errorbox((screenX / 2) - buttonWidth, (screenY / 2) - (buttonHeight / 2), buttonWidth * 2, buttonHeight, "This exercise already exists", BLUE, BLACK, WHITE, font);
    selected = new Button((screenX / 2) - (boxWidth / 4), (screenY - buttonHeight / 2) - (buttonHeight / 4), buttonWidth / 2, buttonHeight / 2, "SELECT", LIGHT_BLUE, BLACK, BLACK, font, () -> select());
    finishButton = new Button((screenX / 2) - (boxWidth / 4), (screenY / 2) - (buttonWidth + 15 + (buttonWidth / 3)), buttonWidth / 2, buttonHeight / 2, "FINISH", LIGHT_BLUE, BLACK, BLACK, font, () -> finish());
    editButton = new Button((screenX / 2) - buttonWidth * 2, (screenY - buttonHeight / 2) - (buttonHeight / 4), buttonWidth, buttonHeight / 2, "EDIT", LIGHT_BLUE, BLACK, BLACK, font,() -> editExercise());
    removeButton = new Button((screenX / 2) + buttonWidth, (screenY - buttonHeight / 2) - (buttonHeight / 4), buttonWidth, buttonHeight / 2, "REMOVE", LIGHT_BLUE, BLACK, BLACK, font,() -> removeExercise());
    
    exerciseScreenButtons.add(addExercise); exerciseScreenButtons.add(selected); exerciseScreenButtons.add(errorBox.getOkButton()); exerciseScreenButtons.add(editButton); exerciseScreenButtons.add(removeButton);
    exerciseScreenTextboxes.add(nameBox); 
    exerciseScreenListboxes.add(exercises);
    
    nameBox.setTextLength(30);
    editButton.setTextSize(20);
    removeButton.setTextSize(20);
    nameBox.setTextSize(28);
    errorBox.setTextSize(30);
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
      editScreen.setBox.setExercise(currentExercise);
      editScreen.setBox.setupScrollbar();
      currentScreen = editScreen;
    }
  }
  public void addExercise()
  {
    nameBox.setIsEditable(true);
    this.setAdded(false);
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
