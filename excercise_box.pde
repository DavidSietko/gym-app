class ExerciseBox extends Listbox
{
  private Exercise exercise;
  private Set[] visibleSets;
  
  ExerciseBox(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, Workout workout, Consumer<Integer> optionClick, Exercise exercise)
  {
    super(x, y, width, height, label, widgetColor, borderColor, labelColor, widgetFont, workout, optionClick);
    this.exercise = exercise;
    this.visibleSets = new Set[VISIBLE_OPTIONS];
    int limit = (this.exercise.getSets().size() < VISIBLE_OPTIONS ? this.exercise.getSets().size() : VISIBLE_OPTIONS);
    for(int i = 0; i < limit; i++)
    {
      visibleSets[i] = this.exercise.getSets().get(i);
    }
  }
  public Set[] getVisibleSets()
  {
    return this.visibleSets;
  }
  public void addSet(int weight, int reps)
  {
    this.exercise.addSet(weight, reps);
    for(int i = 0; i < this.exercise.getSets().size(); i++)
    {
      this.visibleSets[i] = this.exercise.getSets().get(i + this.getOffset());
    }
  }
  @Override
  public void updateVisibleOptions()
  {
    int value = this.getScrollbar().getValue();
    int diff = this.exercise.getSets().size() - VISIBLE_OPTIONS;
    int divisions = (this.getScrollbar().getHeight() - this.getScrollbar().getSliderHeight()) / (diff + 1);
    
    for(int i = 0; i < diff; i++)
    {
      if(value > divisions * i && value <= divisions * (i + 1))
      {
        this.setOffset(i);
        for(int j = 0; j < VISIBLE_OPTIONS; j++)
        {
          this.visibleSets[j] = exercise.getSets().get(i + j);
        }
      }
    }
  }
  public void draw()
  {
    int limit = (this.exercise.getSets().size() < VISIBLE_OPTIONS ? this.exercise.getSets().size() : VISIBLE_OPTIONS);
    
    stroke(this.getBorderColor());
    fill(WHITE);
    rect(this.getX(), this.getY() - (this.getHeight() / 2), this.getWidth(), this.getHeight()/2);
    
    fill(this.getLabelColor());
    textAlign(CENTER, CENTER);
    textSize(20);
    text(this.exercise.getName(), this.getX() + this.getWidth() / 2, this.getY() - (this.getHeight() / 4));
    for(int i = 0; i < limit; i++)
    {
      stroke(this.getBorderColor());
      fill(this.getWidgetColor());
      if(visibleSets[i] != null)
      {
      rect(this.getX(), this.getY() + (this.getHeight() * i), this.getWidth(), this.getHeight());
      fill(this.getLabelColor());
      
      textFont(this.getWidgetFont());
      textAlign(CENTER, CENTER);
      textSize(16);
      text((i + this.getOffset()) + " " + visibleSets[i].toStr(), this.getX() + this.getWidth() / 2, this.getY() + (this.getHeight() * i) + (this.getHeight() / 2));
      }
      
      if(this.exercise.getSets().size() > VISIBLE_OPTIONS)
      {
        this.getScrollbar().draw();
        this.updateVisibleOptions();
      }
    }
  }
}
