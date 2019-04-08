//
//  RoomNormalViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/4/2.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit
import AVFoundation

class RoomNormalViewController: UIViewController,UIGestureRecognizerDelegate {
    
    fileprivate lazy var videoQueue = DispatchQueue.global()
    fileprivate lazy var audioQueue = DispatchQueue.global()
    
    fileprivate var videoOutput : AVCaptureVideoDataOutput?
    fileprivate var videoInput :AVCaptureDeviceInput?
    fileprivate var movieOutput : AVCaptureMovieFileOutput?
//    fileprivate var session : AVCaptureSession?
    fileprivate lazy var session : AVCaptureSession = AVCaptureSession()
    fileprivate lazy var previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)

    private lazy var startBtn : UIButton = {
        let startBtn = UIButton()
        startBtn .setTitle("开始采集", for: UIControl.State.normal)
        startBtn.frame = CGRect(x: 50, y: 200, width: 100, height: 30);
        startBtn .addTarget(self, action: #selector(self.startBtnClicked), for: UIControl.Event.touchUpInside)
        return startBtn
    }()
    private lazy var endBtn : UIButton = {
        let endBtn = UIButton()
        endBtn .setTitle("结束采集", for: UIControl.State.normal)
        endBtn.frame = CGRect(x: 200, y: 200, width: 100, height: 30);
        endBtn .addTarget(self, action: #selector(self.endBtnClicked), for: UIControl.Event.touchUpInside)
        return endBtn
    }()
    
    private lazy var switchBtn : UIButton = {
        let switchBtn = UIButton()
        switchBtn .setTitle("切换摄像头", for: UIControl.State.normal)
        switchBtn.frame = CGRect(x: 50, y: 300, width: 100, height: 30);
        switchBtn .addTarget(self, action: #selector(self.switchBtnClicked), for: UIControl.Event.touchUpInside)
        return switchBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.purple
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //依然保持手势
        //使用自己创建的手势，系统的手势就不需要保持了
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


extension RoomNormalViewController {
    func setupUI() {
        
        view.addSubview(startBtn)
        view.addSubview(endBtn)
        view.addSubview(switchBtn)
    }
}


extension RoomNormalViewController {
    @objc private func startBtnClicked()  {
        //设置视频的输入输出
        setupVideo()
        
        //设置音频的输入输出
        setupAudio()
        
        //添加写入文件的output
        let movieOutput = AVCaptureMovieFileOutput()
        self.movieOutput = movieOutput
        session.addOutput(movieOutput)
        //设置写入的稳定性
        let connection = movieOutput.connection(with: AVMediaType.video)
        connection?.preferredVideoStabilizationMode = .auto
        
        
       
        //4.给用户看到一个预览图层（可选）
        //        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
        //5.开始采集
        session.startRunning()
        
        
        //开始将采集到的画面写入到文件中
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/abc.mp4"
        let url = URL(fileURLWithPath: path)
        
        movieOutput.startRecording(to: url, recordingDelegate: self)
        
        
    }
    
    @objc private func endBtnClicked()  {
        movieOutput?.stopRecording()
        
        session.stopRunning()
        previewLayer.removeFromSuperlayer()
    }
    
    @objc private func switchBtnClicked() {
        //1.获取之前的镜头
        guard var position = videoInput?.device.position else {
            return
        }
        //2.获取应该显示的镜头
        position = position == .front ? .back : .front
        
        //3.根据当前镜头创建新的device
        let devices = AVCaptureDevice.devices(for: AVMediaType.video) as? [AVCaptureDevice]
        
        guard let device = devices?.filter({$0.position == position}).first else {
            return
        }
 
        //4.根据当前的device创建input
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else {
            return
        }

        //5.在session中切换input
        session.beginConfiguration()
        session.removeInput(self.videoInput!)
        session.addInput(videoInput)
        session.commitConfiguration()
        self.videoInput = videoInput
    }
}

extension RoomNormalViewController {
    fileprivate func setupVideo() {
        //1.创建一个捕捉会话
        //        let session = AVCaptureSession()
        //        self.session = session
        //2.给捕捉会话设置输入源(摄像头作为输入源)
        //获取摄像头
        guard let devices = AVCaptureDevice.devices(for: AVMediaType.video) as? [AVCaptureDevice] else {
            print("摄像头不可用")
            return
        }
        
        guard let device = devices.filter({$0.position == .front}).first else {
            return
        }
        //创建input对象
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        self.videoInput = videoInput
        //将input添加到会话中
        session.addInput(videoInput)
        
        //3.给捕捉会话设置输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        session.addOutput(videoOutput)
        

        self.videoOutput = videoOutput
        
    }
    
    fileprivate func setupAudio() {
        //1.设置音频的输入(话筒)
        //1.1获取话筒设备
        guard let device = AVCaptureDevice.default(for: AVMediaType.audio) else {
            return
        }
        //1.2根据device创建AVCaptureInput
        guard let audioInput = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        //1.3将input添加到会话中
        session.addInput(audioInput)
        
        //2.会话设置音频输出源
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: audioQueue)
        session.addOutput(audioOutput)

    }
    
}

extension RoomNormalViewController : AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
   
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if connection == videoOutput?.connection(with: AVMediaType.video) {
            print("已经采集视频画面")
        } else {
            print("已经采集音频画面")
        }
    }
    
}

extension RoomNormalViewController : AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("开始写入")
    }
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("停止写入")
    }
    
    
}
