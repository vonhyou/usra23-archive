import scala.io.Source
import scala.util.{Try, Using, Success, Failure}
import java.net.URL
import sys.process._

@main def main(urlsPath: String) =
  Using.resource(Source.fromFile(urlsPath)) { source =>
    source.getLines().foreach { line =>
      Try(new URL(line)) match
        case Success(value) => openClose(value)
        case Failure(_)     => println(s"`$line` is not a valid URL")
    }
  }

def openClose(url: URL) =
  openURL(url)
  Thread.sleep(2000)
  println(s"[] Open $url")
  closeURL()

def openURL(url: URL) =
  adbTapAt(230, 880) // tap on the search bar
  adbInputText(url.toString()) // input the url
  adbTapAt(1330, 2820) // go to the url

def closeURL() =
  adbTapAt(1200, 185)
  adbTapAt(623, 373)
  adbTapAt(96, 184)

def adbTapAt(x: Int, y: Int) =
  s"adb shell input tap $x $y".!
  Thread.sleep(500)

def adbInputText(text: String) =
  s"""adb shell input text "$text"""".!
  Thread.sleep(500)
