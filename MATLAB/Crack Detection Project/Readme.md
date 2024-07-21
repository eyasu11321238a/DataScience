# 📘 Crack Detector @eyasu

Welcome to the **Basic Crack Detector** project! This README will guide you through the setup, implementation, and usage of the crack detection system developed **Image Analysis and Object Recognition (IAOR)**

---

## 🚀 Project Overview

Structural integrity is crucial for ensuring the safety of buildings and infrastructure. Automated crack detection in structures can aid in timely maintenance and prevent catastrophic failures like the Ponte Morandi collapse in Genoa (2018). This project aims to implement a basic crack detector using traditional image processing techniques.

---

## 📂 Project Structure

- **src/**: Directory containing the source code.
- **data/**: Directory containing the datasets used for training and testing.
- **results/**: Directory containing the output images and performance metrics.

---

## 🛠️ Setup

### Prerequisites

- MATLAB

### Installation

1. **Download and prepare the dataset**:
   - Place your images in the `data/raw` directory.
   - Ensure annotations are in the `data/annotations` directory, labeled as 0 for non-crack and 255 for crack.

---

## 📝 Data Preparation

### Data Acquisition

- Capture images of cracks from various locations while adhering to legal restrictions (e.g., staying on public ground, avoiding privacy invasion).

### Data Annotation

- Annotate images using tools like GIMP or CVAT. Cracks should be labeled with 255 (white), and non-crack regions with 0 (black).

### Data Augmentation

- Optionally, apply transformations like rotation, flipping, contrast adjustment, etc., to expand the dataset without additional data collection.

---

## 🖼️ Image Segmentation

### Thresholding

- Implement thresholding to differentiate cracks from the background. Ensure adaptiveness to varying brightness levels.

### Morphological Processing

- Use morphological operations to refine segmentation results and reduce false positives.

### Feature Extraction

- Extract features such as the number of pixels, perimeter, and eccentricity from segmented regions.

### Classification

- Train classifiers (Support Vector Machine and Decision Tree) to distinguish between crack and non-crack regions based on extracted features.

---

## 📊 Crack Analytics

### Performance Metrics

- Evaluate the model using Intersection over Union (IoU) and report accuracy.

### Crack Length Calculation

- Implement a function to compute the length of detected cracks.

---

## 📈 Results

- **SVM Classifier Accuracy**: 98.1791%
- **Decision Tree Classifier Accuracy**: 98.9378%

The Decision Tree Classifier performed slightly better than the SVM. The high accuracy suggests possible overfitting, indicating the need for a more diverse dataset.

---

## 🗒️ Observations

- The selected features (number of pixels and perimeter) are effective for crack detection.
- Further improvement can be achieved by exploring additional features and ensuring a more diverse dataset.

---

## 📬 Contact

For any queries or feedback, please contact:


Happy coding! 🎉


