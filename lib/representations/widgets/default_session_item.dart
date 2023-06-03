import 'package:flutter/material.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/models/film.dart';
import 'package:onfilm_app/representations/screens/detail/detail_screen.dart';
import 'package:onfilm_app/representations/widgets/load_image.dart';

class DefaultSessionItem extends StatefulWidget {
  final Film film;
  final bool getBackdropImage;

  const DefaultSessionItem(
    this.film,
    this.getBackdropImage, {
    super.key,
  });

  @override
  State<DefaultSessionItem> createState() => _DefaultSessionItemState();
}

class _DefaultSessionItemState extends State<DefaultSessionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          DetailScreen.nameRoute,
          arguments: {
            'id': widget.film.id,
            'type': widget.film.filmType,
          },
        ),
        child: Container(
          // Cases with type is movie or tvshow
          width: widget.getBackdropImage
              ? DimenssionConstant.kWidthBackdropImage
              : DimenssionConstant.kWidthPosterImage,
          margin: const EdgeInsets.only(
            right: DimenssionConstant.kPandingSmall,
          ),
          child: Column(
            crossAxisAlignment: widget.getBackdropImage
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        DimenssionConstant.kRadiusSmall,
                      ),
                      child: LoadImage(
                        widget.getBackdropImage
                            ? widget.film.backdropPath
                            : widget.film.posterPath,
                        false,
                        BoxFit.cover,
                      ),
                    ),
                    if (widget.film.voteAverage > 0)
                      Positioned(
                        top: DimenssionConstant.kPandingSmall,
                        right: DimenssionConstant.kPandingSmall,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            DimenssionConstant.kPandingLarge,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DimenssionConstant.kPandingSmall,
                            ),
                            color: Theme.of(context).colorScheme.primary,
                            child: Text(
                              widget.film.voteAverage.toStringAsFixed(1),
                              style: TextStyleConstant.labelMedium.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: DimenssionConstant.kPandingSmall),
              SizedBox(
                height: DimenssionConstant.kHeightTitleFilm,
                child: Text(
                  textAlign: widget.getBackdropImage
                      ? TextAlign.start
                      : TextAlign.center,
                  widget.film.title.length < 25
                      ? widget.film.title
                      : '${widget.film.title.substring(0, 25)}...',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ),
        ),
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.05),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeIn,
          ),
        ),
        child: FadeTransition(
          opacity: Tween(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeIn,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
