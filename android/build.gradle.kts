import org.gradle.api.tasks.Delete

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.layout.buildDirectory.set(rootProject.layout.projectDirectory.dir("../build"))

subprojects {
    project.layout.buildDirectory.set(rootProject.layout.buildDirectory.map { it.dir(project.name) })
}

subprojects {
    if (project.path != ":app") {
        evaluationDependsOn(":app")
    }
}

tasks.register("clean", Delete::class) {
    delete(rootProject.layout.buildDirectory)
}
