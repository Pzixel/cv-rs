extern crate cv;
mod utils;

use cv::*;
use cv::features2d::*;
use utils::*;

#[test]
fn mser_lenna_detect() {
    let lenna = load_lenna();
    let mser: MSER = MSERBuilder::default().into();
    let (msers, boxes) = mser.detect_regions(&lenna);
    assert_ne!(msers.len(), 0);
    assert_ne!(boxes.len(), 0);
}

#[test]
#[should_panic]
fn mser_lenna_detect_and_compute() {
    let lenna = load_lenna();
    let mask = Mat::new();
    let mser: MSER = MSERBuilder::default().into();
    let (keypoints, descriptors) = mser.detect_and_compute(&lenna, &mask).unwrap();
    assert_ne!(keypoints.len(), 0);
    assert_ne!(descriptors.rows, 0);
    assert_ne!(descriptors.cols, 0);
}
