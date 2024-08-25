class ExerciseBox extends Listbox
{
  private Exercise exercise;
  private Set[] visibleSets;
  
  ExerciseBox(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, Workout workout, Consumer<Integer> optionClick, int visibleOptions, Exercise exercise)
  {
    super(x, y, width, height, label, widgetColor, borderColor, labelColor, widgetFont, workout, optionClick, visibleOptions);
    this.exercise = exercise;
    this.visibleSets = new Set[this.getVisibleOptions()];
    int limit = (this.exercise.getSets().size() < this.getVisibleOptions() ? this.exercise.getSets().size() : this.getVisibleOptions());
    for(int i = 0; i < limit; i++)
    {
      visibleSets[i] = this.exercise.getSets().get(i);
    }
    this.setupScrollbar();
  }
  public void setExercise(Exercise exercise)
  {
    this.exercise = exercise;
  }
  public Exercise getExercise()
  {
    return this.exercise;
  }
  public void setupScrollbar()
  {
    if(this.exercise != null)
    {
       double fraction = (double)this.getVisibleOptions() / (double)this.exercise.getSets().size();
       this.setScrollbar(new Scrollbar(this.getScrollbarX(), this.getScrollbarY(), this.getScrollbarWidth(), this.getScrollbarHeight(), this.getWidgetColor(), BLACK, this.getWidgetFont(), fraction));
    }
  }
  public void removeSet(int index)
  {
    if(index > this.exercise.getSets().size()) {return;}
    else
    {
      this.exercise.getSets().remove(index);
      if(this.getOffset() > 0)
      {
        this.setOffset(this.getOffset() - 1);
      }
      int limit = (this.exercise.getSets().size() < this.getVisibleOptions() ? this.exercise.getSets().size() : this.getVisibleOptions());
      for(int i = 0; i < limit; i++)
      {
        this.visibleSets[i] = this.exercise.getSets().get(i + this.getOffset());
      }
    }
  }
  public Set[] getVisibleSets()
  {
    return this.visibleSets;
  }
  public void addSet(int weight, int reps)
  {
    this.exercise.addSet(weight, reps);
    int limit = (this.exercise.getSets().size() < this.getVisibleOptions() ? this.exercise.getSets().size() : this.getVisibleOptions());
    for(int i = 0; i < limit; i++)
    {
      this.visibleSets[i] = this.exercise.getSets().get(i + this.getOffset());
    }
    if(this.exercise.getSets().size() > this.getVisibleOptions())
    {
      this.setupScrollbar();
    }
  }
  public void setupVisibleSets()
  {
    int limit = (this.exercise.getSets().size() < this.getVisibleOptions() ? this.exercise.getSets().size() : this.getVisibleOptions());
    for(int i = 0; i < limit; i++)
    {
      visibleSets[i] = this.exercise.getSets().get(i + this.getOffset());
    }
  }
  @Override
  public void updateVisibleOptions()
  {
    int value = this.getScrollbar().getValue();
    int diff = this.exercise.getSets().size() - this.getVisibleOptions();
    int divisions = (this.getScrollbar().getHeight() - this.getScrollbar().getSliderHeight()) / (diff);
    
    for(int i = 0; i <= diff; i++)
    {
      if(value >= divisions * i && value <= divisions * (i + 1))
      {
        this.setOffset(i);
        for(int j = 0; j < this.getVisibleOptions(); j++)
        {
          this.visibleSets[j] = exercise.getSets().get(i + j);
        }
      }
    }
  }
  public void draw()
  {
    int limit = (this.exercise.getSets().size() < this.getVisibleOptions() ? this.exercise.getSets().size() : this.getVisibleOptions());
    
    fill(this.getLabelColor());
    textSize(20);
    textAlign(CENTER, CENTER);
    text(this.exercise.getName(), this.getX() + (this.getWidth() / 2), this.getY() - (this.getHeight() / 4));
    for(int i = 0; i < limit; i++)
    {
      stroke(this.getBorderColor());
      fill(this.getWidgetColor());
      if(i == this.getSelected() - this.getOffset())
      {
        fill(GREEN);
      }
      if(visibleSets[i] != null)
      {
      rect(this.getX(), this.getY() + (this.getHeight() * i), this.getWidth(), this.getHeight());
      fill(this.getLabelColor());
      
      textFont(this.getWidgetFont());
      textAlign(CENTER, CENTER);
      textSize(20);
      text(((i + 1) + this.getOffset()) + " " + visibleSets[i].toStr(), this.getX() + this.getWidth() / 2, this.getY() + (this.getHeight() * i) + (this.getHeight() / 2));
      }
    } 
    if(this.exercise.getSets().size() > this.getVisibleOptions())
    {
      this.getScrollbar().draw();
      this.updateVisibleOptions();
    }
  }
}
