package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol(
    // gatling genereaza rapoarte separate fiindca metoda de delete foloseste id-uri random
    "/api/articles/{articleId}" -> Nil
  )

//   protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
//   protocol.runner.karateEnv("perf")

  val createArticle = scenario("Create and delete article").exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))

  setUp(
    createArticle.inject(
        // rampUsers(10) during (5 seconds)
        atOnceUsers(3)
        ).protocols(protocol)
  )

}