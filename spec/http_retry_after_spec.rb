# frozen_string_literal: true

require "spec_helper"

RSpec.describe HttpRetryAfter do
  it "has a version number" do
    expect(HttpRetryAfter::VERSION).not_to be nil
  end

  describe ".parse" do
    context "with numeric delay" do
      it "returns the numeric delay in seconds" do
        expect(HttpRetryAfter.parse("120")).to eq(120)
        expect(HttpRetryAfter.parse("0")).to eq(0)
        expect(HttpRetryAfter.parse("3600")).to eq(3600)
      end

      it "handles string numbers with whitespace" do
        expect(HttpRetryAfter.parse(" 120 ")).to eq(120)
        expect(HttpRetryAfter.parse("\t60\n")).to eq(60)
      end
    end

    context "with HTTP date" do
      it "returns the remaining seconds until the specified time" do
        future_time = Time.now + 300 # 5 minutes in the future
        date_string = future_time.httpdate
        
        result = HttpRetryAfter.parse(date_string)
        expect(result).to be_within(5).of(300) # Allow 5 seconds tolerance
      end

      it "returns 0 for past dates" do
        past_time = Time.now - 300 # 5 minutes in the past
        date_string = past_time.httpdate
        
        expect(HttpRetryAfter.parse(date_string)).to eq(0)
      end

      it "handles various HTTP date formats" do
        future_time = Time.now + 180
        
        # RFC 2822 format
        rfc2822_date = future_time.strftime("%a, %d %b %Y %H:%M:%S %Z")
        expect(HttpRetryAfter.parse(rfc2822_date)).to be_within(5).of(180)
        
        # ISO 8601 format
        iso_date = future_time.iso8601
        expect(HttpRetryAfter.parse(iso_date)).to be_within(5).of(180)
      end
    end

    context "with nil or empty values" do
      it "returns 0 for nil" do
        expect(HttpRetryAfter.parse(nil)).to eq(0)
      end

      it "returns 0 for empty string" do
        expect(HttpRetryAfter.parse("")).to eq(0)
        expect(HttpRetryAfter.parse("   ")).to eq(0)
      end
    end

    context "with invalid values" do
      it "raises InvalidHeaderError for invalid formats" do
        expect { HttpRetryAfter.parse("invalid") }.to raise_error(HttpRetryAfter::InvalidHeaderError)
        expect { HttpRetryAfter.parse("not-a-date-or-number") }.to raise_error(HttpRetryAfter::InvalidHeaderError)
        expect { HttpRetryAfter.parse("12.5") }.to raise_error(HttpRetryAfter::InvalidHeaderError)
      end

      it "includes the invalid value in error message" do
        expect { HttpRetryAfter.parse("invalid") }.to raise_error(HttpRetryAfter::InvalidHeaderError, /invalid/)
      end
    end

    context "real-world examples" do
      it "handles common HTTP Retry-After header values" do
        # Numeric delays
        expect(HttpRetryAfter.parse("60")).to eq(60)
        expect(HttpRetryAfter.parse("3600")).to eq(3600)
        
        # HTTP dates (testing with future dates)
        future_time = Time.now + 600
        http_date = future_time.strftime("%a, %d %b %Y %H:%M:%S GMT")
        expect(HttpRetryAfter.parse(http_date)).to be_within(5).of(600)
      end
    end
  end
end