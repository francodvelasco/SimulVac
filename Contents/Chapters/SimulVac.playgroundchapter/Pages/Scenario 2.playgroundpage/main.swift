/*:
 # What if everyone got the shot?
 Now that we’ve looked at the worse case scenario, let’s look at the flip side: every single person gets the shot. This is the goal, but of course, this can’t realistically happen as certain people can’t take the vaccine, since they’re too young, have a medical condition stopping them from getting the vaccine, or have some other *valid* reason. Nonetheless, what if everyone was protected against COVID-19? Run the code, and see how it would play out.

 More information about the simulation can be found in the i icon in the view.

 Once you’re done, see how another, more plausible scenario, would play out in the next page.

 */

//#-hidden-code
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MainPageViews(percentageVaccinated: 100))
//#-end-hidden-code
