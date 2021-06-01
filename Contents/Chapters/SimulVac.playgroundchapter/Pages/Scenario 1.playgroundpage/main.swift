/*:
 # What if no one gets the shot?
 Let’s look at the worse case scenario: no one gets the shot. This is similar to the situation we were in at the height of the pandemic, when over 800,000 people were getting infected each day, and no vaccine had been approved for emergency use — but this is without any lockdowns, mask mandates, and other measures that could slow the virus. Run the code, and see how it would play out.

 Once you’re done, see how another scenario would play out in the next page.
 */

//#-hidden-code
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(MainPageViews(percentageVaccinated: 0))
//#-end-hidden-code
