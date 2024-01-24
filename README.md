# Custom shape progress indicator



## Usage

    import 'package:custom_shape_progress_indicator/custom_shape_progress_indicator.dart';

### Rectangle progress indicator

    CustomShapeProgressIndicator(
        progress: 0.7,
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)),
            child: const Text('This is a progress indicator'),
        ),
    )

### Infinity progress indicator

    CustomShapeProgressIndicator(
        child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)),
            child: const Text('Infinity progress indicator'),
        ),
    )
    