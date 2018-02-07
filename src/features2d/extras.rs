//! Provide functionallity beyond underlying OpenCV
use super::*;

/// Provide some methods that are useful for
pub trait DMatchSlice {
    fn get_good_matches(&self) -> Vec<DMatch>;
}

impl<'a> DMatchSlice for &'a [DMatch] {
    fn get_good_matches(&self) -> Vec<DMatch> {
        unimplemented!()
    }
}
