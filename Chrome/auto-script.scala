import scala.io.Source
import scala.util.Try
import java.net.URL
import scala.util.Success
import scala.util.Failure

@main def main(urlsPath: String) =
  Source.fromFile(urlsPath).getLines().foreach(openClose)

def openClose(url: String) =
  Try(new URL(url)) match
    case Success(value) => println("Success")
    case Failure(_)     => println(s"`$url` is not a valid URL")
