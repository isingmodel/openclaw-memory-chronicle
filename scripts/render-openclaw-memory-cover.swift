#!/usr/bin/env swift

import AppKit
import Foundation
import ImageIO
import UniformTypeIdentifiers

let repository = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let artworkURL = repository.appendingPathComponent("assets/cover/openclaw-memory-cover-art.png")
let outputURL = repository.appendingPathComponent("assets/cover/openclaw-memory-cover.png")

guard let artwork = NSImage(contentsOf: artworkURL) else {
    fputs("Could not load \(artworkURL.path)\n", stderr)
    exit(1)
}

let width = 1024
let height = 1536
guard
    let bitmap = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: width,
        pixelsHigh: height,
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 32
    ),
    let context = NSGraphicsContext(bitmapImageRep: bitmap)
else {
    fputs("Could not create the cover canvas\n", stderr)
    exit(1)
}

func rectFromTop(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> NSRect {
    NSRect(x: x, y: CGFloat(height) - y - h, width: w, height: h)
}

func font(_ name: String, size: CGFloat, fallbackWeight: NSFont.Weight) -> NSFont {
    NSFont(name: name, size: size) ?? NSFont.systemFont(ofSize: size, weight: fallbackWeight)
}

func drawText(
    _ text: String,
    in rect: NSRect,
    font: NSFont,
    color: NSColor,
    kern: CGFloat = 0
) {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .left
    paragraph.lineBreakMode = .byClipping
    (text as NSString).draw(
        in: rect,
        withAttributes: [
            .font: font,
            .foregroundColor: color,
            .kern: kern,
            .paragraphStyle: paragraph,
        ]
    )
}

NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = context

artwork.draw(
    in: NSRect(x: 0, y: 0, width: width, height: height),
    from: .zero,
    operation: .copy,
    fraction: 1
)

NSColor(calibratedRed: 0.969, green: 0.929, blue: 0.859, alpha: 0.90).setFill()
rectFromTop(0, 0, 1024, 360).fill()

let charcoal = NSColor(calibratedWhite: 0.10, alpha: 1)
let vermilion = NSColor(calibratedRed: 0.76, green: 0.19, blue: 0.15, alpha: 1)
let muted = NSColor(calibratedWhite: 0.34, alpha: 1)

drawText(
    "OPENCLAW MEMORY ARCHITECTURE",
    in: rectFromTop(90, 48, 850, 42),
    font: font("NanumGothicExtraBold", size: 22, fallbackWeight: .bold),
    color: vermilion,
    kern: 5
)

vermilion.setFill()
NSBezierPath(roundedRect: rectFromTop(90, 94, 74, 7), xRadius: 3.5, yRadius: 3.5).fill()

drawText(
    "OpenClaw는",
    in: rectFromTop(86, 114, 850, 86),
    font: font("NanumMyeongjoExtraBold", size: 69, fallbackWeight: .bold),
    color: charcoal,
    kern: -2
)

drawText(
    "어떻게 기억하는가",
    in: rectFromTop(84, 196, 900, 98),
    font: font("NanumMyeongjoExtraBold", size: 76, fallbackWeight: .bold),
    color: charcoal,
    kern: -3
)

drawText(
    "OpenClaw 메모리 구조의 과거와 현재",
    in: rectFromTop(90, 300, 820, 48),
    font: font("NanumGothic", size: 29, fallbackWeight: .medium),
    color: muted,
    kern: 0.5
)

NSGraphicsContext.restoreGraphicsState()

guard
    let composedImage = bitmap.cgImage,
    let flattenedContext = CGContext(
        data: nil,
        width: width,
        height: height,
        bitsPerComponent: 8,
        bytesPerRow: width * 4,
        space: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue
    )
else {
    fputs("Could not flatten the cover image\n", stderr)
    exit(1)
}

flattenedContext.setFillColor(NSColor.white.cgColor)
flattenedContext.fill(CGRect(x: 0, y: 0, width: width, height: height))
flattenedContext.draw(composedImage, in: CGRect(x: 0, y: 0, width: width, height: height))

guard
    let flattenedImage = flattenedContext.makeImage(),
    let destination = CGImageDestinationCreateWithURL(
        outputURL as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
    )
else {
    fputs("Could not create the PNG destination\n", stderr)
    exit(1)
}

CGImageDestinationAddImage(destination, flattenedImage, nil)
guard CGImageDestinationFinalize(destination) else {
    fputs("Could not encode the cover as PNG\n", stderr)
    exit(1)
}

print("Rendered \(outputURL.path)")
