//! Provide 2D image feature detectors and descriptor extractors
mod descriptor_matcher;
mod extras;
mod mser;
mod surf;
mod sift;

use core::*;

pub use self::descriptor_matcher::*;
pub use self::extras::*;
pub use self::mser::*;
pub use self::sift::*;
pub use self::surf::*;

/// Basic trait for 2D image feature detectors and descriptor extractors
pub trait Feature2D {
    /// Detects keypoints and computes the descriptors
    fn detect_and_compute(&self, image: &Mat, mask: &Mat) -> (Vec<KeyPoint>, Mat);
}
