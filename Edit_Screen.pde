class EditScreen extends Screen
{
  private ExerciseBox setBox;
  private Bar bar;
  private Button addSet, removeButton, editButton, saveButton, currentButton, finishButton;
  private Numberbox weightBox, repBox;
  
  private boolean editable;
  
  private int boxWidth = 200;
  private int boxHeight = 50;
  private int selectedSet = -1;
  
  EditScreen()
  {
    this.editable = false;
    
    setBox = new ExerciseBox((screenX / 2) - (boxWidth * 4), (screenY / 2) + 20, boxWidth * 8, boxHeight * 2, "", GREY, BLACK, BLACK, font, currentWorkout, index -> selectSet(index), 3, currentExercise);
    weightBox = new Numberbox((screenX / 2) - (boxWidth * 2), screenY / 4, boxWidth * 4, boxHeight * 2, "WEIGHT: ", WHITE, BLACK, BLACK, font);
    repBox = new Numberbox((screenX / 2) - (boxWidth * 2), (screenY / 4) +  (boxHeight * 2), boxWidth * 4, boxHeight * 2, "REPS:", WHITE, BLACK, BLACK, font);
    addSet = new Button(screenX - (screenX / 8), screenY / 24, buttonWidth / 2, buttonHeight / 2, "ADD SET", WHITE, BLACK, BLACK, font, () -> addSet());
    removeButton = new Button((screenX / 2) + buttonWidth * 3, (screenY - (screenY / 2) - (buttonHeight - buttonHeight / 3)) - (buttonHeight / 4), buttonWidth, buttonHeight / 2, "REMOVE", LIGHT_BLUE, BLACK, BLACK, font,() -> removeSet());
    editButton = new Button((screenX / 2) - buttonWidth * 4, (screenY - (screenY / 2) - (buttonHeight - buttonHeight / 3)) - (buttonHeight / 4), buttonWidth, buttonHeight / 2, "EDIT", LIGHT_BLUE, BLACK, BLACK, font,() -> editSet());
    saveButton = new Button((screenX / 2) - buttonWidth * 4, (screenY - (screenY / 2) - (buttonHeight - buttonHeight / 3)) - (buttonHeight / 4), buttonWidth, buttonHeight / 2, "SAVE", BLUE, BLACK, BLACK, font,() -> saveSet());
    finishButton = new Button(screenX - (screenX / 8) - (buttonWidth), screenY / 24, buttonWidth / 2, buttonHeight / 2, "FINISH", WHITE, BLACK, BLACK, font, () -> finish());
    currentButton = editButton;

    bar = new Bar(0, 0, screenX, 200, currentExercise.getName(), LIGHT_BLUE, WHITE);
    
    editScreenTextboxes.add(weightBox); editScreenTextboxes.add(repBox);
    editScreenButtons.add(removeButton); editScreenButtons.add(addSet); editScreenButtons.add(editButton); editScreenButtons.add(finishButton);
    editScreenListboxes.add(setBox);
    
    addSet.setTextSize(20);
    removeButton.setTextSize(20); editButton.setTextSize(20); saveButton.setTextSize(20); finishButton.setTextSize(20);
    weightBox.setTextSize(24);
    repBox.setTextSize(24);
    bar.setTextSize(80);
  }
  public boolean getEditable()
  {
    return this.editable;
  }
  public void setEditable(boolean editable)
  {
    this.editable = editable;
  }
  
  public void addSet()
  {
    setBox.addSet(int(weightBox.getText()), int(repBox.getText()));
  }
  public void removeSet()
  {
    if(selectedSet >= 0)
    {
       setBox.removeSet(selectedSet);
    }
    this.selectedSet = -1;
    setBox.setSelected(selectedSet);
  }
  public void selectSet(int index)
  {
    selectedSet = index;
    println(index);
  }
  public void editSet()
  {
    this.setEditable(!this.getEditable());
    if(currentExercise.getSets().size() > 0)
    {
      editScreenButtons.remove(editButton);
      currentButton = saveButton;
      editScreenButtons.add(saveButton);
    }
  }
  public void saveSet()
  {
    if(selectedSet >= 0)
    {
       editScreenButtons.remove(editButton);
       setBox.exercise.getSets().get(selectedSet).setWeight(int(weightBox.getText()));
       setBox.exercise.getSets().get(selectedSet).setReps(int(repBox.getText()));
       editScreenButtons.add(editButton);
       editScreenButtons.remove(saveButton);
       currentButton = editButton;
       editButton.setClicked(false);
       this.setEditable(false);
    }
  }
  public void finish()
  {
    workoutScreen.addExerciseBox(setBox);
    workoutScreen.addButtons();
    currentScreen = workoutScreen;
  }
  public void draw()
  {
    bar.setLabel(currentExercise.getName());
    bar.draw();
    setBox.draw();
    addSet.draw();
    removeButton.draw();
    weightBox.draw();
    repBox.draw();
    currentButton.draw();
    finishButton.draw();
    if(this.editable)
    {
      fill(BLUE);
      textAlign(RIGHT, BOTTOM);
      textSize(24);
      text("CLICK ON A SET, EDIT THE VALUES AND CLICK SAVE", screenX / 2 + buttonWidth, (screenY + buttonWidth / 5) - buttonWidth);
    }
  }
}
