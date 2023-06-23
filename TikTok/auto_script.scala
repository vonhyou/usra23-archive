import scala.io.StdIn.readLine
import java.time.Instant
import sys.process._

@main def main(duration: Long, interval: Int) =
  print(
    s"The script will swipe every $interval seconds in the next $duration minutes, is this correct? (y/N)"
  )

  readLine().trim().toLowerCase() match
    case "y" => run(duration, interval)
    case _   => print("exit")

def run(duration: Long, interval: Int) =
  val now = Instant.now()
  val endTime = now.plusSeconds(duration * 60)
  while Instant.now().isBefore(endTime) do
    "adb shell input swipe 700 2300 700 1000".!
    println(s"[Log] Next swipe: $interval seconds.")
    Thread.sleep(interval * 1000)
