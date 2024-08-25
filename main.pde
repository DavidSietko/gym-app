void settings()
{
  size(screenX, screenY);
}
void setup()
{
  loadResources();
}
void draw()
{
  background(WHITE);
  currentScreen.draw();
}
void mousePressed()
{
  if(currentScreen == selectScreen)
  {
    for(int i = 0; i < selectScreenButtons.size(); i++)
    {
       Button b = selectScreenButtons.get(i);
       b.isClicked(mouseX, mouseY);
    }
  }
  if(currentScreen == exerciseScreen)
  {
    for(int i = 0; i < exerciseScreenButtons.size(); i++)
    {
      Button button = exerciseScreenButtons.get(i);
      button.isClicked(mouseX, mouseY);
    }
    for(int i = 0; i < exerciseScreenListboxes.size(); i++)
    {
      Listbox l = exerciseScreenListboxes.get(i);
      l.getScrollbar().getClicked(mouseX, mouseY);
      for(int j = 0; j < l.getVisibleOptions(); j++)
      {
        l.optionIsClicked(j, mouseX, mouseY);
      }
    }
  }
  if(currentScreen == editScreen)
  {
    for(int i = 0; i < editScreenButtons.size(); i++)
    {
      Button b = editScreenButtons.get(i);
      b.isClicked(mouseX, mouseY);
    }
    for(int i = 0; i < editScreenTextboxes.size(); i++)
    {
      Textbox box = editScreenTextboxes.get(i);
      box.isClicked(mouseX, mouseY);
    }
    for(int i = 0; i < editScreenListboxes.size(); i++)
    {
      Listbox l = editScreenListboxes.get(i);
      l.getScrollbar().getClicked(mouseX, mouseY);
      for(int j = 0; j < l.getVisibleOptions(); j++)
      {
        l.optionIsClicked(j, mouseX, mouseY);
      }
    }
  }
  if(currentScreen == workoutScreen)
  {
    for(int i = 0; i < workoutScreenButtons.size(); i++)
    {
      Button b = workoutScreenButtons.get(i);
      b.isClicked(mouseX, mouseY);
    }
    for(int i = 0; i < workoutScreenListboxes.size(); i++)
    {
      Listbox l = workoutScreenListboxes.get(i);
      l.getScrollbar().getClicked(mouseX, mouseY);
      for(int j = 0; j < l.getVisibleOptions(); j++)
      {
        l.optionIsClicked(j, mouseX, mouseY);
      }
    }
  }
}
void mouseDragged()
{
  if(currentScreen == exerciseScreen)
  {
    for(int i = 0; i < exerciseScreenListboxes.size(); i++)
    {
      Listbox l = exerciseScreenListboxes.get(i);
      l.getScrollbar().getDragged(mouseY, pmouseY);
    }
  }
  if(currentScreen == editScreen)
  {
    for(int i = 0; i < editScreenListboxes.size(); i++)
    {
      Listbox l = editScreenListboxes.get(i);
      l.getScrollbar().getDragged(mouseY, pmouseY);
    }
  }
  if(currentScreen == workoutScreen)
  {
    for(int i = 0; i < workoutScreenListboxes.size(); i++)
    {
      Listbox l = workoutScreenListboxes.get(i);
      l.getScrollbar().getDragged(mouseY, pmouseY);
    }
  }
}
void mouseReleased()
{
  if(currentScreen == exerciseScreen)
  {
    for(int i = 0; i < exerciseScreenListboxes.size(); i++)
    {
      Listbox l = exerciseScreenListboxes.get(i);
      l.getScrollbar().toggleRelease();
    }
  }
  if(currentScreen == editScreen)
  {
    for(int i = 0; i < editScreenListboxes.size(); i++)
    {
      Listbox l = editScreenListboxes.get(i);
      l.getScrollbar().toggleRelease();
    }
  }
  if(currentScreen == workoutScreen)
  {
    for(int i = 0; i < workoutScreenListboxes.size(); i++)
    {
      Listbox l = workoutScreenListboxes.get(i);
      l.getScrollbar().toggleRelease();
    }
  }
}
void mouseMoved()
{
  
}
void keyPressed()
{
  if(currentScreen == selectScreen)
  {
    for(int i = 0; i < selectScreenTextboxes.size(); i++)
    {
      Textbox textbox = selectScreenTextboxes.get(i);
      textbox.editText();
      textbox.stopEditing();
    }
  }
  if(currentScreen == exerciseScreen)
  {
    for(int i = 0; i < exerciseScreenTextboxes.size(); i++)
    {
      Textbox textbox = exerciseScreenTextboxes.get(i);
      textbox.editText();
      textbox.stopEditing();
    }
  }
  if(currentScreen == editScreen)
  {
    for(int i = 0; i < editScreenTextboxes.size(); i++)
    {
      Textbox textbox = editScreenTextboxes.get(i);
      textbox.editText();
      textbox.stopEditing();
    }
  }
}
void exit()
{
  saveButtons(selectScreen.workoutButtons, "buttons.json");
  saveButtonWorkouts(selectScreen.workouts, "workouts.json");
  saveWorkout(currentWorkout);
}
