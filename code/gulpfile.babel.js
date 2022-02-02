'use strict';
const gulp = require('gulp');
const glob = require('gulp-sass-glob');
const sass = require('gulp-sass')(require('sass'));
const yargs = require('yargs');

const PRODUCTION = !!(yargs.argv.production);

var SASS_FOLDER = 'static/sass';

const { watch, series } = require('gulp');

// print('PRODUCTION: '+ PRODUCTION);

function rebuildSass() {
  console.log('Rebulding sass...')
  var ret = gulp.src('./' + SASS_FOLDER +'/**/*.scss')
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('./static/css'));

    console.log('Sass rebuilt.')

   return ret;
};

// function siteSass() {
//     return gulp.src( SASS_FOLDER + '/**/*.scss')
//     .pipe(glob())
//     .pipe($.if(!yargs.argv.production, $.sourcemaps.init()))
//     .pipe($.sass({outputStyle: outputStyle}).on('error', $.sass.logError))
//     .pipe($.if(!yargs.argv.production, $.sourcemaps.write()))
//     .pipe(gulp.dest('static/css'))
//     .pipe(browser.stream());
// }

function siteWatch() {
    gulp.watch([ SASS_FOLDER + '/**/*.scss'], {interval: 1000, usePolling: true}).on('change', rebuildSass);
    // gulp.watch(['static/js/**/*.js']).on('change', browser.reload);
}

// console.log('PRODUCTION: ', PRODUCTION);

if(PRODUCTION == false)
{
  // for DEV only watch for changes as the prod command will rebuilt the sass anyway
	gulp.task('default',
  		gulp.series(siteWatch));
} else {
	gulp.task('default',
  		gulp.series(rebuildSass));
}



// gulp.task('sass',
//   gulp.series(siteSass));
