/*:
 # SimulVac
 Want to see even more possible vaccination scenarios? Change the values using the sliders and see what effect they can bring to the pandemic.

 You can change the percentage of the population vaccinated, and the ratio of vaccine brands used by the vaccinated.
 */

//#-hidden-code
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(CustomSimView(percentageVaccinated: 0))
//#-end-hidden-code
