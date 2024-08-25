class WorkoutScreen extends Screen
{
  private ArrayList<ExerciseBox>  allExercises;
  private ExerciseBox[] visibleExercises;
  
  private int offset;
  final int VISIBLE_EXERCISES = 4;
  private boolean nullWorkout;
  
  private Bar bar;
  private Button toExercises, nextExercise, prevExercise, backButton, forwardButton, startWorkout, clearButton;
  
  WorkoutScreen()
  {
    this.offset = 0;
    this.allExercises = new ArrayList<ExerciseBox>();
    this.visibleExercises = new ExerciseBox[VISIBLE_EXERCISES];
    this.nullWorkout = false;
    
    bar = new Bar(0, 0, screenX, 200, currentWorkout.getName() + " " + currentDate.toString(), LIGHT_BLUE, WHITE);
    toExercises = new Button(0 + screenX / 8, bar.getHeight() + 20, buttonWidth, buttonHeight / 2, "TO EXERCISES", LIGHT_BLUE, BLACK, BLACK, font, () -> toExercises());
    nextExercise = new Button((screenX / 2) - (boxWidth * 2), screenY - (20 + (buttonHeight / 2)), buttonWidth / 2, buttonHeight / 2, "NEXT", LIGHT_BLUE, BLACK, BLACK, font, () -> nextExercise());
    prevExercise = new Button((screenX / 2) - (boxWidth * 2), bar.getHeight() + 20, buttonWidth / 2, buttonHeight / 2, "PREV", LIGHT_BLUE, BLACK, BLACK, font, () -> prevExercise());
    backButton = new Button(20, bar.getHeight() + 20, buttonWidth / 2, buttonHeight / 2, "BACK", LIGHT_BLUE, BLACK, BLACK, font, () -> lastWorkout());
    forwardButton = new Button(screenX - (20 + (buttonWidth / 2)), bar.getHeight() + 20, buttonWidth / 2, buttonHeight / 2, "FORWARD", LIGHT_BLUE, BLACK, BLACK, font, () -> nextWorkout());
    startWorkout = new Button((screenX / 2) - buttonWidth, (screenY / 2) - (buttonHeight / 2), buttonWidth * 2, buttonHeight, "START WORKOUT", LIGHT_BLUE, BLACK, BLACK, font, () -> startWorkout());
    clearButton = new Button(screenX - (screenX / 8 + buttonWidth), bar.getHeight() + 20, buttonWidth, buttonHeight / 2, "CLEAR", LIGHT_BLUE, BLACK, BLACK, font, () -> clearWorkout());
    
     workoutScreenButtons.add(toExercises); 
     workoutScreenButtons.add(prevExercise); 
     workoutScreenButtons.add(nextExercise);
     workoutScreenButtons.add(backButton); workoutScreenButtons.add(forwardButton);
    toExercises.setTextSize(24); prevExercise.setTextSize(20); nextExercise.setTextSize(20); backButton.setTextSize(20); forwardButton.setTextSize(20); startWorkout.setTextSize(40); clearButton.setTextSize(24);
    bar.setTextSize(80);
    this.setupWorkout();
    
    this.setupVisibleExercises();
  }
  public boolean getNullWorkout()
  {
    return this.nullWorkout;
  }
  public void setNullWorkout(boolean nullWorkout)
  {
    this.nullWorkout = nullWorkout;
  }
  public void toExercises()
  {
    currentScreen = exerciseScreen;
  }
  public void addExerciseBox(ExerciseBox box)
  {
    ExerciseBox b = null;
    boolean exists = false;
    for(int i = 0; i < allExercises.size(); i ++)
    {
      if(allExercises.get(i).getExercise().getName().equals(box.getExercise().getName()))
      {
        exists = true;
        b = allExercises.get(i);
      }
    }
    if(!exists)
    {
    this.allExercises.add(new ExerciseBox((screenX / 2) - boxWidth, bar.getHeight() + 20, boxWidth * 2, boxHeight, box.getLabel(), GREY, BLACK, BLACK, font, currentWorkout, index -> selectedExercise(index), 3, box.getExercise()));
    }
    else
    {
      b.setExercise(box.getExercise());
      b.setupVisibleSets();
      b.setupScrollbar();
    }
    this.setupVisibleExercises();
  }
  public void setupVisibleExercises()
  {
    int limit = (this.allExercises.size() < VISIBLE_EXERCISES ? this.allExercises.size() : VISIBLE_EXERCISES);
    for(int i = 0; i < limit; i++)
    {
      workoutScreenListboxes.remove(visibleExercises[i]);
    }
   for(int i = 0; i < limit; i++)
   {
     visibleExercises[i] = this.allExercises.get(i + this.offset);
     visibleExercises[i].setY((bar.getHeight() + 30) + ((visibleExercises[i].getVisibleOptions() * boxHeight) * i) + (50 * i));
     visibleExercises[i].getScrollbar().setInitialY((bar.getHeight() + 30) + ((visibleExercises[i].getVisibleOptions() * boxHeight) * i) + (50 * i));
     visibleExercises[i].getScrollbar().setY((bar.getHeight() + 30) + ((visibleExercises[i].getVisibleOptions() * boxHeight) * i) + (50 * i));
     workoutScreenListboxes.add(visibleExercises[i]);
   }
  }
  public void setupWorkout()
  {
    if(currentWorkout.getName() != "")
    {
      for(int i = 0; i < currentWorkout.getExercises().size(); i++)
      {
        if(currentWorkout.getExercises().get(i).getSets().size() > 0)
        {
          allExercises.add(new ExerciseBox((screenX / 2) - boxWidth, bar.getHeight() + 20, boxWidth * 2, boxHeight, currentWorkout.getExercises().get(i).getName(), GREY, BLACK, BLACK, font, currentWorkout, index -> selectedExercise(index), 3, currentWorkout.getExercises().get(i)));
        }
      }
    }
  }
  public void selectedExercise(int index)
  {
     int limit = (this.allExercises.size() < VISIBLE_EXERCISES ? this.allExercises.size() : VISIBLE_EXERCISES);
     for(int i = 0; i < limit; i++)
     {
       ExerciseBox b = visibleExercises[i];
       if(b.getSelected() >= 0)
       {
         currentScreen = editScreen;
         currentExercise = b.getExercise();
         editScreen.setBox.setExercise(currentExercise);
         editScreen.setBox.setupScrollbar();
         editScreen.setBox.setupVisibleSets();
         b.setSelected(-1);
       }
     }
  }
  public void nextExercise()
  {
    int diff = allExercises.size() - VISIBLE_EXERCISES;
    if(diff > 0 && this.offset < diff)
    {
      this.offset++;
      this.setupVisibleExercises();
    }
  }
  public void prevExercise()
  {
    int diff = allExercises.size() - VISIBLE_EXERCISES;
    if(diff > 0 && this.offset > 0)
    {
      this.offset--;
      this.setupVisibleExercises();
    }
  }
  public void lastWorkout()
  {
    currentDate = currentDate.minusDays(1);
    this.updateWorkout();
    currentWorkout = loadWorkout(currentDate.toString());
    if(currentWorkout.getName() != "")
    {
      this.setNullWorkout(false);
      if(!workoutScreenButtons.contains(toExercises)){workoutScreenButtons.add(toExercises);}
      if(!workoutScreenButtons.contains(prevExercise)){workoutScreenButtons.add(prevExercise);}
      if(!workoutScreenButtons.contains(nextExercise)){workoutScreenButtons.add(nextExercise);}
      if(!workoutScreenButtons.contains(clearButton)){workoutScreenButtons.add(clearButton);}
      workoutScreenButtons.remove(startWorkout);
      this.offset = 0;
      allExercises.clear();
      this.setupWorkout();
      this.setupVisibleExercises();
      exerciseScreen.exercises.setWorkout(currentWorkout);
      exerciseScreen.exercises.setupScrollbar();
    }
    else
    {
      this.setNullWorkout(true);
      workoutScreenButtons.remove(clearButton);
      workoutScreenButtons.remove(toExercises);
      workoutScreenButtons.remove(prevExercise);
      workoutScreenButtons.remove(nextExercise);
      if(!workoutScreenButtons.contains(startWorkout)){workoutScreenButtons.add(startWorkout);}
      int limit = (this.allExercises.size() < VISIBLE_EXERCISES ? this.allExercises.size() : VISIBLE_EXERCISES);
      for(int i = 0; i < limit; i++)
      {
        workoutScreenButtons.remove(visibleExercises[i]);
      }
    }
  }
  public void nextWorkout()
  {
    currentDate = currentDate.plusDays(1);
    this.updateWorkout();
    currentWorkout = loadWorkout(currentDate.toString());
    if(currentWorkout.getName() != "")
    {
      this.setNullWorkout(false);
      if(!workoutScreenButtons.contains(toExercises)){workoutScreenButtons.add(toExercises);}
      if(!workoutScreenButtons.contains(prevExercise)){workoutScreenButtons.add(prevExercise);}
      if(!workoutScreenButtons.contains(nextExercise)){workoutScreenButtons.add(nextExercise);}
      if(!workoutScreenButtons.contains(clearButton)){workoutScreenButtons.add(clearButton);}
      workoutScreenButtons.remove(startWorkout);
      this.offset = 0;
      allExercises.clear();
      this.setupWorkout();
      this.setupVisibleExercises();
      exerciseScreen.exercises.setWorkout(currentWorkout);
      exerciseScreen.exercises.setupScrollbar();
    }
    else
    {
      this.setNullWorkout(true);
      workoutScreenButtons.remove(clearButton);
      workoutScreenButtons.remove(toExercises);
      workoutScreenButtons.remove(prevExercise);
      workoutScreenButtons.remove(nextExercise);
      if(!workoutScreenButtons.contains(startWorkout)){workoutScreenButtons.add(startWorkout);}
      int limit = (this.allExercises.size() < VISIBLE_EXERCISES ? this.allExercises.size() : VISIBLE_EXERCISES);
      for(int i = 0; i < limit; i++)
      {
        workoutScreenButtons.remove(visibleExercises[i]);
      }
    }
  }
  public void startWorkout()
  {
    currentScreen = selectScreen;
    this.setNullWorkout(false);
    allExercises.clear();
    workoutScreenButtons.remove(startWorkout);
  }
  public void updateWorkout()
  {
    if(currentWorkout.getName() != "")
    {
      saveWorkout(currentWorkout);
    }
  }
  public void clearWorkout()
  {
     currentWorkout = new Workout("","");
     deleteWorkout(currentDate.toString() + ".json");
     this.setNullWorkout(true);
     workoutScreenButtons.remove(toExercises);
     workoutScreenButtons.remove(prevExercise);
     workoutScreenButtons.remove(nextExercise);
     workoutScreenButtons.add(startWorkout);
     int limit = (this.allExercises.size() < VISIBLE_EXERCISES ? this.allExercises.size() : VISIBLE_EXERCISES);
     for(int i = 0; i < limit; i++)
     {
       workoutScreenButtons.remove(visibleExercises[i]);
     }
  }
  public void draw()
  {
    bar.setLabel(currentWorkout.getName() + " " + currentDate.toString());
    bar.draw();
    backButton.draw();
    forwardButton.draw();
    if(!this.getNullWorkout())
    {
      toExercises.draw();
      prevExercise.draw();
      nextExercise.draw();
      clearButton.draw();
      int limit = (this.allExercises.size() < VISIBLE_EXERCISES ? this.allExercises.size() : VISIBLE_EXERCISES);
      for(int i = 0; i < limit; i++)
      {
        visibleExercises[i].draw();
      }
    }
    else
    {
      startWorkout.draw();
    }
  }
}
