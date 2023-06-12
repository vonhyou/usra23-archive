import java.nio.ByteBuffer
import java.nio.file.{Files, Paths, StandardOpenOption}

@main def hello(name: String, number: Int, size: Int): Unit =
  for i <- 0 until(number) do
    createDummyFile(s"$name-$i.zip", size)

def createDummyFile(name: String, size: Int) =
  val buffer = ByteBuffer.allocate(1024 * 1024)
  val path = Paths.get(name)
  val channel = Files.newByteChannel(path, StandardOpenOption.CREATE, StandardOpenOption.WRITE)
  for _ <- 0 until(size) do
    buffer.clear()
    channel.write(buffer)
  channel.close()