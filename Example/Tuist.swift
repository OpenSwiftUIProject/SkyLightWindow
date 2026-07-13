import ProjectDescription

let tuist = Tuist(
    project: .tuist(
        generationOptions: .options(
            additionalPackageResolutionArguments: [
                "-clonedSourcePackagesDirPath", "../../../.build/xcode-packages",
            ]
        )
    )
)
