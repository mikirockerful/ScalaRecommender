name         := "Recommender"
version      := "2.0.0"


scalaVersion := "2.11.8"

libraryDependencies ++= Seq(
  "org.apache.spark" %% "spark-core" % "2.1.3",
  "org.apache.spark" %% "spark-sql" % "2.1.3",
  "org.apache.spark" %% "spark-mllib" % "2.1.3",
  "org.apache.spark" %% "spark-graphx" % "2.1.3"
)
