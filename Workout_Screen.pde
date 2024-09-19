class WorkoutScreen extends Screen
{
  private ArrayList<ExerciseBox>  allExercises;
  private ExerciseBox[] visibleExercises;
  
  private int offset;
  final int VISIBLE_EXERCISES = 3;
  private boolean nullWorkout, removing;
  
  private Bar bar;
  private Button toExercises, nextExercise, prevExercise, backButton, forwardButton, startWorkout, clearButton, removeButton;
  
  WorkoutScreen()
  {
    this.offset = 0;
    this.allExercises = new ArrayList<ExerciseBox>();
    this.visibleExercises = new ExerciseBox[VISIBLE_EXERCISES];
    this.nullWorkout = false;
    this.removing = false;
    
    bar = new Bar(0, 0, screenX, 200, currentWorkout.getName() + " " + currentDate.toString(), LIGHT_BLUE, WHITE);
    toExercises = new Button(screenX / 8, screenY / 24, buttonWidth, buttonHeight / 2, "TO EXERCISES", WHITE, BLACK, BLACK, font, () -> toExercises());
    removeButton = new Button(screenX / 8, bar.getHeight() + 20, buttonWidth, buttonHeight / 2, "REMOVE", LIGHT_BLUE, BLACK, BLACK, font, () -> removeExercise());
    nextExercise = new Button(20, screenY - (buttonHeight + buttonHeight / 4), buttonWidth / 2, buttonHeight / 2, "NEXT", LIGHT_BLUE, BLACK, BLACK, font, () -> nextExercise());
    prevExercise = new Button(20, bar.getHeight() + 20, buttonWidth / 2, buttonHeight / 2, "PREV", LIGHT_BLUE, BLACK, BLACK, font, () -> prevExercise());
    backButton = new Button(20, screenY / 24, buttonWidth / 2, buttonHeight / 2, "BACK", WHITE, BLACK, BLACK, font, () -> lastWorkout());
    forwardButton = new Button(screenX - (20 + (buttonWidth / 2)), screenY / 24, buttonWidth / 2, buttonHeight / 2, "FORWARD", WHITE, BLACK, BLACK, font, () -> nextWorkout());
    startWorkout = new Button((screenX / 2) - buttonWidth, (screenY / 2) - (buttonHeight / 2), buttonWidth * 2, buttonHeight, "START WORKOUT", LIGHT_BLUE, BLACK, BLACK, font, () -> startWorkout());
    clearButton = new Button(screenX - (screenX / 8 + buttonWidth), bar.getHeight() + 20, buttonWidth, buttonHeight / 2, "CLEAR", LIGHT_BLUE, BLACK, BLACK, font, () -> clearWorkout());
    
     workoutScreenButtons.add(toExercises); 
     workoutScreenButtons.add(prevExercise); 
     workoutScreenButtons.add(nextExercise);
     workoutScreenButtons.add(backButton); workoutScreenButtons.add(forwardButton); workoutScreenButtons.add(clearButton); workoutScreenButtons.add(removeButton);
    toExercises.setTextSize(24); prevExercise.setTextSize(20); nextExercise.setTextSize(20); backButton.setTextSize(20); forwardButton.setTextSize(20); startWorkout.setTextSize(40);
    clearButton.setTextSize(24); removeButton.setTextSize(24);
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
    this.allExercises.add(new ExerciseBox((screenX / 2) - boxWidth * 2, bar.getHeight() + buttonHeight / 2, boxWidth * 4, boxHeight, box.getLabel(), GREY, BLACK, BLACK, font, currentWorkout, index -> selectedExercise(index), 3, box.getExercise()));
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
     visibleExercises[i].setY((bar.getHeight() + buttonHeight / 3) + ((visibleExercises[i].getVisibleOptions() * boxHeight) * i) + (50 * i));
     visibleExercises[i].getScrollbar().setInitialY((bar.getHeight() + buttonHeight / 3) + ((visibleExercises[i].getVisibleOptions() * boxHeight) * i) + (50 * i));
     visibleExercises[i].getScrollbar().setY((bar.getHeight() + buttonHeight / 3) + ((visibleExercises[i].getVisibleOptions() * boxHeight) * i) + (50 * i));
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
          allExercises.add(new ExerciseBox((screenX / 2) - boxWidth * 2, bar.getHeight() + buttonHeight, boxWidth * 4, boxHeight, currentWorkout.getExercises().get(i).getName(), GREY, BLACK, BLACK, font, currentWorkout, index -> selectedExercise(index), 3, currentWorkout.getExercises().get(i)));
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
       if(b.getSelected() >= 0 && !this.removing)
       {
         currentScreen = editScreen;
         currentExercise = b.getExercise();
         editScreen.setBox.setExercise(currentExercise);
         editScreen.setBox.setupScrollbar();
         editScreen.setBox.setupVisibleSets();
         b.setSelected(-1);
       }
       else if(b.getSelected() >= 0 && this.removing)
       {
         allExercises.remove(b);
         this.setupVisibleExercises();
         this.removing = false;
         currentWorkout.getSpecificExercise(b.getExercise().getName()).clearSets();
         updateWorkout();
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
      this.addButtons();
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
      this.removeButtons();
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
      this.addButtons();
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
      this.removeButtons();
      if(!workoutScreenButtons.contains(startWorkout)){workoutScreenButtons.add(startWorkout);}
      int limit = (this.allExercises.size() < VISIBLE_EXERCISES ? this.allExercises.size() : VISIBLE_EXERCISES);
      for(int i = 0; i < limit; i++)
      {
        workoutScreenButtons.remove(visibleExercises[i]);
      }
    }
  }
  public void addButtons()
  {
      if(!workoutScreenButtons.contains(toExercises)){workoutScreenButtons.add(toExercises);}
      if(!workoutScreenButtons.contains(prevExercise)){workoutScreenButtons.add(prevExercise);}
      if(!workoutScreenButtons.contains(nextExercise)){workoutScreenButtons.add(nextExercise);}
      if(!workoutScreenButtons.contains(clearButton)){workoutScreenButtons.add(clearButton);}
      if(!workoutScreenButtons.contains(removeButton)){workoutScreenButtons.add(removeButton);}
  }
  public void removeButtons()
  {
      workoutScreenButtons.remove(clearButton);
      workoutScreenButtons.remove(toExercises);
      workoutScreenButtons.remove(prevExercise);
      workoutScreenButtons.remove(nextExercise);
      workoutScreenButtons.remove(removeButton);
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
     removeButtons();
     workoutScreenButtons.add(startWorkout);
     int limit = (this.allExercises.size() < VISIBLE_EXERCISES ? this.allExercises.size() : VISIBLE_EXERCISES);
     for(int i = 0; i < limit; i++)
     {
       workoutScreenButtons.remove(visibleExercises[i]);
     }
  }
  public void removeExercise()
  {
    this.removing = !this.removing;
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
      removeButton.draw();
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
    if(this.removing)
    {
      fill(BLUE);
      textSize(24);
      textAlign(BOTTOM, CENTER);
      text("CLICK ON AN EXERCISE TO REMOVE IT", screenX / 3 + buttonWidth, screenY - buttonWidth);
    }
  }
}
