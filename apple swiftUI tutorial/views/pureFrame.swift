////
////  pureFrame.swift
////  apple swiftUI tutorial
////
////  Created by David Gaz on 03.06.2020.
////  Copyright © 2020 David Gaz. All rights reserved.
////
//
//import SwiftUI
//
//struct pureFrame: View {
//    //    @State var w: CGFloat = 200
//    //    @State var h: CGFloat = 50
//    //    @State var angle: Double  = 0
//    //    @State var inputAngle = "ee"
//    //    @State  var currentPosition: CGSize = .zero
//    //    @State  var     newPosition: CGSize = .zero
//    //
//        @State var templateItem: itemPreview = StoryPreviews[0]
//    //    @State  var img = SwiftUIPhotoSelector(x:242, y:463, h:269, w:45)
//    var body: some View {
//        //        ZStack{
//        //            GeometryReader{ geo1 in
//                        Image(self.templateItem.image)
//                            .resizable()
//                            .layoutPriority(5000)
//                            .aspectRatio(contentMode: .fit)
//                            .overlay(
//        GeometryReader{ geom in
//            //            SwiftUIPhotoSelector(x:0, y:0,
//            //            h:300,
//            //            w:50)
//            //            Rectangle()
//            //                .frame(width: geom.size.width, height: 70)
//            //                .opacity(0.2)
//            
////            SwiftUIPhotoSelector()
////                .layoutPriority(190)
////                .frame(width: geom.size.width/1.36, height: geom.size.width/1.36)
////                .mask(
////                    Rectangle()
////                        .size(width : geom.size.width/1.36, height: geom.size.width/1.36)
////            )
//            
////            photoSelector(  w:geom.size.width/1.36,          h:geom.size.width/1.36 )
////                .layoutPriority(190)
////                .frame(width: geom.size.width/1.36, height: geom.size.width/1.36)
////                .position(
////                    x: geom.size.width/1.36/2+geom.size.width*0.130,
////                    y: geom.size.width/1.36/2+geom.size.width*0.133
////            )
//            
////            photoSelector(w:geom.size.width/1.36,
////                          h:geom.size.width/1.68
////            )
////                .layoutPriority(190)
////                .position(x: geom.size.width/1.36/2+geom.size.width*0.130,
////                          y: geom.size.width/1.68/2+geom.size.width*1.051
////            )
//            //                        .background(Color.red)
//                                }
//        )
//        
//        //        ZStack{
//        
////        .layoutPriority(150)
//        //                     }
//        //            .resizable()
//        //            .aspectRatio(contentMode: .fit)
//        //                SwiftUIPhotoSelector(x:242, y:463,
//        //                                     h:geo.size.width/1.36,
//        //                                     w:geo.size.width/1.36)
//        //                    .position(
//        //                        x: geo.size.width/1.36/2+geo.size.width*0.130,
//        //                        y: geo.size.width/1.36/2+geo.size.width*0.133
//        //                )
//        //
//        //                SwiftUIPhotoSelector(x:242, y:463,
//        //                                     h:geo.size.width/1.68,
//        //                                     w:geo.size.width/1.36)
//        //                    .position(x: geo.size.width/1.36/2+geo.size.width*0.130,
//        //                              y: geo.size.width/1.68/2+geo.size.width*1.051
//        //                )
//        //            }
//        //                    .opacity(0.2)
//        
//        //                ZStack{
//        //                    VStack{
//        //                        Text("w:\(Int(self.w)) h:\(Int(self.h)) a:\(Int(self.angle))")
//        //                        HStack{
//        //                            Slider(value: self.$angle, in: -30...30, step: 1)
//        //                            Text("\(Int(self.angle))")
//        //                        }
//        //                        HStack{
//        //                            Slider(value: self.$h, in: 30...300, step: 1)
//        //                            Text("\(Int(self.h))")
//        //                        }
//        //                        HStack{
//        //                            Slider(value: self.$w, in: 30...360, step: 1)
//        //                            Text("\(Int(self.w))")
//        //                        }
//        //                        Text("\(Int(self.w))")
//        //                    }
//        //                    .position(x: 180, y: 100)
//        //                    ZStack{
//        //
//        //                        Rectangle()
//        //                        .opacity(0.0)
//        //                        .border( Color.red,width: 2)
//        //                        .addComandButton()
//        //                        .frame(width: self.w, height: self.h)
//        //                        .rotationEffect(Angle(degrees: self.angle))
//        //                            .overlay(ZStack{
//        //                                GeometryReader{ rGeo in
//        //                                    VStack{
//        //                                    Text("\((rGeo.frame(in: .named("imageFrame")).minX)/geo.size.width) \((rGeo.frame(in: .named("imageFrame")).midY - self.h/2)/geo.size.width)")
//        //                                        Text("\(geo.size.width/self.w) \(geo.size.width/self.h)")
//        //                                    }
//        //                                }
//        //
//        //                            })
//        //                        .offset(self.currentPosition)
//        //                        .gesture(DragGesture(minimumDistance: 5)
//        //                            .onChanged({value in
//        //                                self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width,
//        //                                                              height: value.translation.height + self.newPosition.height)
//        //                            })
//        //                            .onEnded({ value in
//        //                                self.newPosition = self.currentPosition
//        //                            }))
//        //                        }
//        //                }
//        //                .frame(width: 250, height: 100)
//        //            }
//        //                .foregroundColor(Color.green)
//        //                .background(Color.red)
//        //            .coordinateSpace(name: "imageFrame")
//        
//        
//        
//        //        }
//        //                .frame(width: 1080/3, height: 1920/3)
//        
//        
//        //        }
//    }
//}
//
//struct pureFrame_Previews: PreviewProvider {
//    static var previews: some View {
//        pureFrame()
//    }
//}
